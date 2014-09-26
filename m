From: "Tan, Joshua Chu Yeaw" <joshua.chu.yeaw.tan@intel.com>
Subject: ASoC DPCM has issues when multiple FEs links to same type of codec.
Date: Fri, 26 Sep 2014 02:56:55 +0000
Message-ID: <E8645821A2816A4380DAD4F80FFE7DB01BF2F2BB@PGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi, 

ALSA ASoC DPCM FE - BE connection doesn't handle the scenario when a machine driver has multiple FEs linking to same codec type. 

Let me use dummy codec as example codec:

	FE1 - BE1 (connected to dummy codec  instance #1)
	FE2 - BE2 (connected to dummy codec  instance #2)
	FE3 - BE3 (connected to dummy codec  instance #3)

DPCM will not be able to correctly identify the Back End from the 2nd pair onwards. 
This happens as the codec .stream_name is used 3 times to connect to different Back-Ends.

Say I am using the dummy codec that has a playback .stream_name "Dummy Playback" with 3 I2S AIF.

E.g. I have 3 BE dai links:
static struct snd_soc_dai_link xxx_dailink[] = {
	...
	{
		 .name = "I2S0-Codec",
		.be_id = 1,
		.cpu_dai_name = "i2s0-port",
		.platform_name = "xxx-platform",
		.no_pcm = 1,
		.codec_dai_name = "snd-soc-dummy-dai",
		.codec_name = "snd-soc-dummy",
	} 
	{
		.name = "I2S1-Codec",
		.be_id = 2,
		.cpu_dai_name = "i2s1-port",
		.platform_name = "xxx-platform",
		.no_pcm = 1,
		.codec_dai_name = "snd-soc-dummy-dai",
		.codec_name = "snd-soc-dummy",
	} 
	{
		.name = "I2S2-Codec",
		.be_id = 3,
		.cpu_dai_name = "i2s2-port",
		.platform_name = "xxx-platform",
		.no_pcm = 1,
		.codec_dai_name = "snd-soc-dummy-dai",
		.codec_name = "snd-soc-dummy",
	}

/*DAPM routing*/
static const struct snd_soc_dapm_route map[] = {
	{ "Dummy Playback", NULL, "I2S0 Tx"},
	{ "Dummy Playback", NULL, "I2S1 Tx"},
	{ "Dummy Playback", NULL, "I2S2 Tx"},
	...
}

The order of the DAI Link affects the connection of the codec stream name widget on a first come first serve basis,  in this case, first declared DAI link codec is used.
In soc-pcm.c, when dpcm_fe_dai_open tries to add paths for the 2nd(and later) FE, dpcm_add_paths function will always discover the "Dummy Playback" widget belonging to the back-end of the first DAI link and link it incorrectly.

1. dpcm_add_paths() finds "Dummy Playback" is a snd_soc_dapm_dai_in type, and calls dpcm_get_be()

	1101	 static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
	1102       	  struct snd_soc_dapm_widget_list **list_)
	... 
	1120                 	/* is there a valid BE rtd for this widget */
	1121                 	be = dpcm_get_be(card, list->widgets[i], stream); 

2. The dpcm_get_be will traverse the list for "Dummy Playback" and return the first back end found.
Line 994 below always finds that I2S0-Codec link matches this condition and will not proceed further to match I2S1-Codec

990         if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
991                 for (i = 0; i < card->num_links; i++) {
992                         be = &card->rtd[i];
993 
994                         if (!be->dai_link->no_pcm)	
995                                 continue;
996 
997                         if (be->cpu_dai->playback_widget == widget ||
998                                 be->codec_dai->playback_widget == widget)
999                                 return be;
1000                 }
1001         } else {    --> Same effect also happens in the capture path.


E.g. When I try to playback on the i2s1 (2nd playback device), the following fe-be link happens :
Widget = "I2S1 Tx", Back End = "I2S1-Codec"		--> This is the intended link.
Widget = "Dummy Playback", Back End = "I2S0-Codec" 	--> This is additional problematic link because the first discovered "Dummy Playback" is from the codec in the first DAI link.

This results in soc_pcm_open called twice in dpcm_be_dai_startup function; first for the first Back End (undesired), and then only the correct Back End 

Is it possible to add some instance id to the codec name, or some check on the intended FE-BE pairing? 


Regards,
Joshua
