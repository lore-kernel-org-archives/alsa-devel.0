From: Denis Sbragion <d.sbragion@infotecna.it>
Subject: EWX and SPDIF, can you take a look at this?
Date: Mon, 30 Jun 2003 18:49:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.1.20030630183626.01e77e60@pop3.infotecna.lcl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

may be unrelated or not. I noticed that in aplay.c (0.9.4), at line 818, 
the sample rate setting is obtained with:

rate = hwparams.rate;
err = snd_pcm_hw_params_set_rate_near(handle, params, &hwparams.rate, 0);

Is it correct to use a reference (&) to set the sample rate? Looking at the 
hwparams structure and the snd_pcm_hw_params_set_rate_near definition I 
think this should be just:

err = snd_pcm_hw_params_set_rate_near(handle, params, hwparams.rate, 0);

BruteFIR set the sample rate with:

     /* It seems like it is best to set_rate_near instead of exact, have had
        problems with ens1371 */
     if ((err = snd_pcm_hw_params_set_rate_near(handle, params,
                                                sample_rate, 0)) < 0)
     {
...

No & here. I think either one or the other is a bug. This is the only 
relevant difference I found between the BF initialization sequence and the 
arecord one, so it may be related with the SPDIF problem with the EWX 
considering the different behaviour between the two.

Thanks for the attention, and sorry if this is just a mistake in my 
understanding on how ALSA works.

Bye,
--
	Denis Sbragion
	InfoTecna
	Tel: +39 0362 805396, Fax: +39 0362 805404
	URL: http://www.infotecna.it



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
