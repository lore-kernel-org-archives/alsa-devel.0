From: Canella Matteo <Matteo.Canella@mta.it>
Subject: period_size and .asoundrc
Date: Mon, 25 May 2009 15:12:17 +0200
Message-ID: <BD9F3F3F5A6CCF4BA032B9FED4DD312E8938AE@mta-digimail.MTA.INT>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190]) by alsa0.perex.cz (Postfix) with ESMTP id 3295424384
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 15:12:30 +0200 (CEST)
Received: from mailserver.mta.int (mail.mta.it [89.96.171.250])
	by rly04a.srv.mailcontrol.com (MailControl) with ESMTP id
	n4PDCS50019396
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2009 14:12:28 +0100
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi everybody,
I'm writing a little software that play a tone on a pcm device.
In the hw param initialization I'm hardcoding the "periods" and "period_size" values:

                unsigned int periods = 4;
                if (snd_pcm_hw_params_set_periods_near(buzzer_device.pcm_handle, buzzer_device.hwparams, &periods, 0) < 0) {
                               fprintf(stderr, "Error setting periods.\n");
                               return 1;
                }
                ///* set the period time */
                period_size = 8192;
                err = snd_pcm_hw_params_set_period_size_near(buzzer_device.pcm_handle, buzzer_device.hwparams, &period_size, 0);
                if (err < 0) {
                               printf("Unable to get period size for playback: %s\n", snd_strerror(err));
                               return err;
                }

I'd like to read this parameter form the .asoundrc file, so I'm wondering if there were API that does this task.

Thanks

Matteo Canella
