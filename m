From: Fortini Matteo <matteo.fortini@mta.it>
Subject: Alsa not working when linked to a library
Date: Fri, 25 Sep 2009 19:05:50 +0200
Message-ID: <4ABCF86E.40801@mta.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190])
	by alsa0.perex.cz (Postfix) with ESMTP id A8E9E1037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 19:05:58 +0200 (CEST)
Received: from mail.mta.it (mail.mta.it [89.96.171.250])
	by rly19a.srv.mailcontrol.com (MailControl) with ESMTP id
	n8PH5tRU003780
	for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2009 18:05:56 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I'm experiencing a very strange behavior.

I'm using alsa 1.0.18 on a powerpc platform.

If I run the following simple code from the main of a .c file, it works 
perfectly, but if I put into a shared .so library (libaudio.so), then I 
link the main with -laudio -lasound, then the hwparams structure is not 
filled with anything, while the alsa functions don't return any error.

Do you have any clue why this could happen?

TIA

############################################################
int play_sample(char *pcm_name, char *samplename)
{
    int res;
    snd_pcm_t *pcm_handle;         
    snd_pcm_hw_params_t *hwparams;           
    const char *name= (pcm_name != NULL) ? pcm_name : "speaker";

    if ( (res = snd_pcm_open(&pcm_handle, name, SND_PCM_STREAM_PLAYBACK, 
0)) < 0) {
        fprintf(stderr, "Error opening PCM device %s\n", pcm_name);
        return 1;
    } else {
        printf ("snd_pcm_open returned %d\n", res);
    }

  
    snd_pcm_hw_params_malloc(&hwparams);
    if (snd_pcm_hw_params_any(pcm_handle, hwparams) < 0) {
        fprintf(stderr, "Can not configure this PCM device.\n");
        return 1;

   snd_pcm_close(pcm_handle);
}


int main (void)
{
    play_sample (NULL, "test_sound.wav);

    return 0;
}
############################################################
