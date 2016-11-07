From: "Bode, Michael (PED-DEAS)" <Michael.Bode@bshg.com>
Subject: Re: Imx6 i2s master driver without i2c
Date: Mon, 7 Nov 2016 16:17:53 +0000
Message-ID: <d9c6b8ddfb414d63a6dbe05059ccde24@MCHSWIEXMB5A.bsh.corp.bshg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout02.rmx.de (mailout02.rmx.de [62.245.148.41])
 by alsa0.perex.cz (Postfix) with ESMTP id A3D85266DE4
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 17:18:28 +0100 (CET)
Received: from cryptout03.retarus.com (unknown [172.19.21.159])
 by mailout02.rmx.de (Postfix) with ESMTP id 3tCHg610CZzNnND
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 17:18:26 +0100 (CET)
Received: from cryptout03.dmz2.retloc (localhost [127.0.0.1])
 by cryptout03.retarus.com (Postfix) with ESMTP id 025F51B421EE
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 17:18:21 +0100 (CET)
Received: from mailcc09.dmz2.retloc (mailcc09.retarus.de [172.19.21.9])
 by cryptout03.retarus.com (Postfix) with SMTP id D647A1B421EE
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 17:18:20 +0100 (CET)
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I know, it's some time ago since there was this discussion ongoing. I don't know if you already solved your problems.
Because I had a similar task to solve I maybe have some information that could help here:

In my case calling function "snd_soc_dai_set_pll(cpu_dai, 0, 0, 688128000, itel_audio_fmts[i].sysclk);" was not working. When looking into the details I found that underlying
Driver (in my case fsl_ssi.c) had not implemented function "set_pll", so calling this function was just a dummy. Then I tried to figure out how to manipulate the Audio PLL in i.MX6 and
Found the file "clk-imx6q.c" which sets all clocks of i.MX6.  To register a clock the function clk_register_clkdev needs to be called for that clock. Now I found that this registration was missing for
PLL4 which in my case should be used for audio. So I added "clk_register_clkdev(clk[IMX6QDL_CLK_PLL4_AUDIO_DIV], "pll4", NULL);".
With this change I was able to call "pll4 = clk_get(NULL, "pll4");" from my SOC-driver and do a  pllRate = clk_round_rate(pll4, 688128000); and clk_set_rate(pll4, pllRate);
Finally with this I was able to change Audio PLL according to sample rate to get proper SSI signals.

A second thing I found in your chat was that you had the problem that no matter what sample frequency you use, you always get 44100. I also ran into that issue and found that there is an ALSA feature active
That intentionally converts the audio rate. I found the config file asound.conf in /etc that defines:

pcm.dmix_44100{
type dmix
ipc_key 5678293
ipc_key_add_uid yes
slave{
pcm "hw:0,0"
period_time 40000
buffer_time 360000
format S16_LE
rate 44100
}
}

pcm.asymed{
type asym
playback.pcm "dmix_44100"
capture.pcm "dsnoop_44100"
}

As a result all my frequencies were intentionally converted to 44100 Hz. So my solution was to just rename/delete asound.conf

I hope this can help others to get an i.MX I2S Master running.


Best regards,
Michael Bode
