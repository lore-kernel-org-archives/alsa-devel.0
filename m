From: Giuliano Pochini <pochini@shiny.it>
Subject: sample rate rule problems
Date: Sun, 16 May 2004 17:34:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040516173442.32ae71b4.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



I'm trying to write a rule for the Layla24. That card supports all standard
sample rates 8KHz-96KHz and continuous rates only in the range 25KHz-100KHz.
I wrote this rule, but ALSA gets confused and it sometimes chooses a wrong
value, sometimes fails. I can't figure out why. This is the rule:


{
	snd_interval_t *rate = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
	unsigned int rates[] = {8000, 11025, 16000, 22050, 32000, 44100, 48000, 88200, 96000, 0};
	int r;

	printk("req min=%d max=%d\n",rate->min,rate->max);

	if (rate->max < 25000) {
		printk("list\n");
		return snd_interval_list(rate, 4, rates, 0);
	}

	if (rate->min >= 25000 && rate->min == rate->max) {
		/* If it's a standard rate, do nothing */
		for (r = 0; rates[r]; r++)
			if (rates[r] == rate->min)
				return(0);
		printk("cont\n");
		params->rate_num = LAYLA24_MAGIC_NUMBER;
		params->rate_den = LAYLA24_MAGIC_NUMBER / rate->min;
	}
	return 0;
}


If it is a standard sample rate or it's in the continuous range, it's all
right. Otherwise snd_pcm_hw_params_set_rate_near() fails:

[Giu@Jay Giu]$ aplay -v -f S32_LE -c 2 -r 11020 -D hw:0,0,2 booo.html
Playing raw data 'wget' : Signed 32 bit Little Endian, Rate 11020 Hz, Stereo
aplay: aplay.c:824: set_params: Assertion `err >= 0' failed.




--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
