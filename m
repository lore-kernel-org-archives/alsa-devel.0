From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [Fwd: Re: [pulseaudio-discuss] pulseaudio debug
	mode]
Date: Tue, 27 Jul 2010 08:36:57 +0800
Message-ID: <AANLkTinQSgUz8vjikxC5v-Pq_HqqpFwZ1cDCb3si6U3T@mail.gmail.com>
References: <1280097015.29696.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 593EF24442
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 02:36:59 +0200 (CEST)
Received: by vws20 with SMTP id 20so3454770vws.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 17:36:58 -0700 (PDT)
In-Reply-To: <1280097015.29696.8.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/26 Chris <cpollock@embarqmail.com>

> Raymond, attached is a post I made today to the pulseaudio list.
>
> --
> Chris
> KeyID 0xE372A7DA98E6705C
>
>
http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/7204/focus=7218

Refer to the log  http://pastebin.com/tZNYaqRV


What is the meaning of "memblock.c: Pool full" ?
How large is this pool ?
Is this memblock used for storing audio data ?


   1. Jul 26 09:05:31 localhost pulseaudio[26721]: (48035.021|   5.573)
   ratelimit.c: 522 events suppressed
   2. Jul 26 09:05:31 localhost pulseaudio[26721]: (48035.035|   0.014)
   asyncq.c: q overrun, queuing locally
   3. Jul 26 09:05:31 localhost pulseaudio[26721]: (48035.035|   0.000)
   asyncq.c: q overrun, queuing locally
   4. Jul 26 09:05:31 localhost pulseaudio[26721]: (48035.035|   0.000)
   asyncq.c: q overrun, queuing locally
   5. Jul 26 09:05:31 localhost pulseaudio[26721]: (48035.035|   0.000)
   asyncq.c: q overrun, queuing locally
   6. Jul 26 09:05:31 localhost pulseaudio[26721]: (48035.035|   0.000)
   asyncq.c: q overrun, queuing locally
   7. Jul 26 09:05:31 localhost pulseaudio[26721]: (48035.035|   0.000)
   asyncq.c: q overrun, queuing locally
   8. Jul 26 09:05:31 localhost pulseaudio[26721]: (48035.035|   0.000)
   asyncq.c: q overrun, queuing locally
   9. Jul 26 09:05:31 localhost pulseaudio[26721]: (48035.035|   0.000)
   asyncq.c: q overrun, queuing locally
   10. Jul 26 09:05:31 localhost pulseaudio[26721]: (48035.035|   0.000)
   asyncq.c: q overrun, queuing locally
   11. Jul 26 09:05:31 localhost pulseaudio[26721]: (48035.035|   0.000)
   asyncq.c: q overrun, queuing locally
   12. Jul 26 09:05:31 localhost pulseaudio[26721]: (48035.035|   0.000)
   asyncq.c: q overrun, queuing locally
   13. Jul 26 09:05:31 localhost pulseaudio[26721]: (48035.035|   0.000)
   alsa-sink.c: Increasing wakeup watermark to 140.00 ms
   14. Jul 26 09:05:36 localhost pulseaudio[26721]: (48040.068|   5.033)
   ratelimit.c: 1032 events suppressed
   15. Jul 26 09:05:36 localhost pulseaudio[26721]: (48040.083|   0.014)
   asyncq.c: q overrun, queuing locally
   16. Jul 26 09:05:36 localhost pulseaudio[26721]: (48040.083|   0.000)
   asyncq.c: q overrun, queuing locally
   17. Jul 26 09:05:36 localhost pulseaudio[26721]: (48040.083|   0.000)
   asyncq.c: q overrun, queuing locally
   18. Jul 26 09:05:36 localhost pulseaudio[26721]: (48040.083|   0.000)
   asyncq.c: q overrun, queuing locally
   19. Jul 26 09:05:36 localhost pulseaudio[26721]: (48040.083|   0.000)
   asyncq.c: q overrun, queuing locally
   20. Jul 26 09:05:36 localhost pulseaudio[26721]: (48040.083|   0.000)
   asyncq.c: q overrun, queuing locally
   21. Jul 26 09:05:36 localhost pulseaudio[26721]: (48040.083|   0.000)
   asyncq.c: q overrun, queuing locally
   22. Jul 26 09:05:36 localhost pulseaudio[26721]: (48040.083|   0.000)
   asyncq.c: q overrun, queuing locally
   23. Jul 26 09:05:36 localhost pulseaudio[26721]: (48040.083|   0.000)
   asyncq.c: q overrun, queuing locally
   24. Jul 26 09:05:36 localhost pulseaudio[26721]: (48040.083|   0.000)
   memblock.c: Pool full
   25. Jul 26 09:05:36 localhost pulseaudio[26721]: (48040.083|   0.000)
   memblock.c: Pool full
   26. Jul 26 09:05:41 localhost pulseaudio[26721]: (48045.075|   4.992)
   ratelimit.c: 1154 events suppressed
   27. Jul 26 09:05:41 localhost pulseaudio[26721]: (48045.107|   0.031)
   asyncq.c: q overrun, queuing locally
   28. Jul 26 09:05:41 localhost pulseaudio[26721]: (48045.107|   0.000)
   memblock.c: Pool full
   29. Jul 26 09:05:41 localhost pulseaudio[26721]: (48045.107|   0.000)
   asyncq.c: q overrun, queuing locally
   30. Jul 26 09:05:41 localhost pulseaudio[26721]: (48045.107|   0.000)
   asyncq.c: q overrun, queuing locally
   31. Jul 26 09:05:41 localhost pulseaudio[26721]: (48045.107|   0.000)
   asyncq.c: q overrun, queuing locally
   32. Jul 26 09:05:41 localhost pulseaudio[26721]: (48045.107|   0.000)
   asyncq.c: q overrun, queuing locally
   33. Jul 26 09:05:41 localhost pulseaudio[26721]: (48045.107|   0.000)
   memblock.c: Pool full
   34. Jul 26 09:05:41 localhost pulseaudio[26721]: (48045.117|   0.009)
   memblock.c: Pool full
   35. Jul 26 09:05:42 localhost pulseaudio[26721]: (48045.127|   0.010)
   memblock.c: Pool full
   36. Jul 26 09:05:42 localhost pulseaudio[26721]: (48045.148|   0.020)
   asyncq.c: q overrun, queuing locally
   37. Jul 26 09:05:42 localhost pulseaudio[26721]: (48045.148|   0.000)
   asyncq.c: q overrun, queuing locally


Look like PA server decreasing wakeup watermark until underrun occur after
Freeing input 14 "bell-window-system"

this decreasing/increasing wakeup watermark cycle is repeated a few time

Are there any PA clients still connected to PA server ?




   1. Jul 26 09:07:13 localhost pulseaudio[26721]: (48137.022|   0.000)
   alsa-sink.c: Latency set to 150.00ms
   2. Jul 26 09:07:13 localhost pulseaudio[26721]: (48137.022|   0.000)
   alsa-sink.c: hwbuf_unused=39076
   3. Jul 26 09:07:13 localhost pulseaudio[26721]: (48137.022|   0.000)
   alsa-sink.c: setting avail_min=11091
   4. Jul 26 09:07:13 localhost pulseaudio[26721]: (48137.022|   0.000)
   alsa-sink.c: Requested to rewind 65536 bytes.
   5. Jul 26 09:07:13 localhost pulseaudio[26721]: (48137.022|   0.000)
   alsa-sink.c: Limited to 5252 bytes.
   6. Jul 26 09:07:13 localhost pulseaudio[26721]: (48137.022|   0.000)
   alsa-sink.c: before: 1313
   7. Jul 26 09:07:13 localhost pulseaudio[26721]: (48137.022|   0.000)
   alsa-sink.c: after: 1313
   8. Jul 26 09:07:13 localhost pulseaudio[26721]: (48137.022|   0.000)
   alsa-sink.c: Rewound 5252 bytes.
   9. Jul 26 09:07:13 localhost pulseaudio[26721]: (48137.022|   0.000)
   sink.c: Processing rewind...
   10. Jul 26 09:07:13 localhost pulseaudio[26721]: (48137.022|   0.000)
   source.c: Processing rewind...
   11. Jul 26 09:07:13 localhost pulseaudio[26721]: (48137.024|   0.001)
   sink-input.c: Freeing input 14 "bell-window-system"




   1. Jul 26 09:07:33 localhost pulseaudio[26721]: (48157.094|  20.069)
   alsa-sink.c: Decreasing wakeup watermark to 115.06 ms
   2. Jul 26 09:07:53 localhost pulseaudio[26721]: (48177.108|  20.013)
   alsa-sink.c: Decreasing wakeup watermark to 110.07 ms
   3. Jul 26 09:08:13 localhost pulseaudio[26721]: (48197.143|  20.035)
   alsa-sink.c: Decreasing wakeup watermark to 105.08 ms
   4. Jul 26 09:08:34 localhost pulseaudio[26721]: (48217.152|  20.008)
   alsa-sink.c: Decreasing wakeup watermark to 100.09 ms
   5. Jul 26 09:30:19 localhost pulseaudio[26721]: (49522.760|1305.608)
   alsa-sink.c: Underrun!
   6. Jul 26 09:30:19 localhost pulseaudio[26721]: (49522.760|   0.000)
   alsa-sink.c: Increasing wakeup watermark to 110.09 ms
   7. Jul 26 09:30:39 localhost pulseaudio[26721]: (49542.813|  20.052)
   alsa-sink.c: Decreasing wakeup watermark to 105.10 ms
   8. Jul 26 09:31:18 localhost pulseaudio[26721]: (49581.831|  39.018)
   alsa-sink.c: Decreasing wakeup watermark to 100.11 ms
   9.
   10. Jul 26 10:11:01 localhost pulseaudio[26721]: (51964.860|2383.029)
   alsa-sink.c: Underrun!
   11. Jul 26 10:11:01 localhost pulseaudio[26721]: (51964.888|   0.028)
   alsa-sink.c: Increasing wakeup watermark to 110.11 ms



   1. Jul 26 10:11:10 localhost pulseaudio[26721]: (51974.048|   9.160)
   asyncq.c: q overrun, queuing locally
   2. Jul 26 10:11:10 localhost pulseaudio[26721]: (51974.049|   0.000)
   asyncq.c: q overrun, queuing locally
   3. Jul 26 10:11:10 localhost pulseaudio[26721]: (51974.049|   0.000)
   asyncq.c: q overrun, queuing locally
   4. Jul 26 10:11:10 localhost pulseaudio[26721]: (51974.089|   0.040)
   asyncq.c: q overrun, queuing locally
   5. Jul 26 10:11:10 localhost pulseaudio[26721]: (51974.089|   0.000)
   asyncq.c: q overrun, queuing locally
   6. Jul 26 10:11:10 localhost pulseaudio[26721]: (51974.129|   0.039)
   asyncq.c: q overrun, queuing locally
   7. Jul 26 10:11:10 localhost pulseaudio[26721]: (51974.129|   0.000)
   asyncq.c: q overrun, queuing locally
   8. Jul 26 10:11:11 localhost pulseaudio[26721]: (51974.168|   0.039)
   asyncq.c: q overrun, queuing locally
   9. Jul 26 10:11:11 localhost pulseaudio[26721]: (51974.169|   0.000)
   asyncq.c: q overrun, queuing locally
   10. Jul 26 10:11:11 localhost pulseaudio[26721]: (51974.208|   0.039)
   asyncq.c: q overrun, queuing locally
   11. Jul 26 10:11:11 localhost pulseaudio[26721]: (51974.208|   0.000)
   asyncq.c: q overrun, queuing locally
   12. Jul 26 10:11:15 localhost pulseaudio[26721]: (51978.185|   3.976)
   alsa-sink.c: Increasing wakeup watermark to 120.11 ms
   13. Jul 26 10:11:15 localhost pulseaudio[26721]: (51979.064|   0.878)
   ratelimit.c: 258 events suppressed
   14. Jul 26 10:11:15 localhost pulseaudio[26721]: (51979.064|   0.000)
   asyncq.c: q overrun, queuing locally
   15. Jul 26 10:11:15 localhost pulseaudio[26721]: (51979.064|   0.000)
   asyncq.c: q overrun, queuing locally
   16. Jul 26 10:11:15 localhost pulseaudio[26721]: (51979.094|   0.029)
   asyncq.c: q overrun, queuing locally
   17. Jul 26 10:11:15 localhost pulseaudio[26721]: (51979.094|   0.000)
   asyncq.c: q overrun, queuing locally
   18. Jul 26 10:11:15 localhost pulseaudio[26721]: (51979.124|   0.029)
   asyncq.c: q overrun, queuing locally
   19. Jul 26 10:11:15 localhost pulseaudio[26721]: (51979.124|   0.000)
   asyncq.c: q overrun, queuing locally
   20. Jul 26 10:11:16 localhost pulseaudio[26721]: (51979.154|   0.029)
   asyncq.c: q overrun, queuing locally
   21. Jul 26 10:11:16 localhost pulseaudio[26721]: (51979.154|   0.000)
   asyncq.c: q overrun, queuing locally
   22. Jul 26 10:11:16 localhost pulseaudio[26721]: (51979.154|   0.000)
   asyncq.c: q overrun, queuing locally
   23. Jul 26 10:11:16 localhost pulseaudio[26721]: (51979.184|   0.029)
   asyncq.c: q overrun, queuing locally
   24. Jul 26 10:11:16 localhost pulseaudio[26721]: (51979.214|   0.030)
   asyncq.c: q overrun, queuing locally
   25. Jul 26 10:11:20 localhost pulseaudio[26721]: (51984.088|   4.874)
   ratelimit.c: 85 events suppressed
   26. Jul 26 10:11:20 localhost pulseaudio[26721]: (51984.088|   0.000)
   asyncq.c: q overrun, queuing locally
   27. Jul 26 10:11:20 localhost pulseaudio[26721]: (51984.088|   0.000)
   asyncq.c: q overrun, queuing locally
   28. Jul 26 10:11:20 localhost pulseaudio[26721]: (51984.118|   0.029)
   asyncq.c: q overrun, queuing locally
   29. Jul 26 10:11:20 localhost pulseaudio[26721]: (51984.118|   0.000)
   asyncq.c: q overrun, queuing locally
   30. Jul 26 10:11:21 localhost pulseaudio[26721]: (51984.148|   0.029)
   asyncq.c: q overrun, queuing locally
   31. Jul 26 10:11:21 localhost pulseaudio[26721]: (51984.148|   0.000)
   asyncq.c: q overrun, queuing locally
   32. Jul 26 10:11:21 localhost pulseaudio[26721]: (51984.148|   0.000)
   asyncq.c: q overrun, queuing locally
   33. Jul 26 10:11:21 localhost pulseaudio[26721]: (51984.178|   0.029)
   asyncq.c: q overrun, queuing locally
   34. Jul 26 10:11:21 localhost pulseaudio[26721]: (51984.178|   0.000)
   asyncq.c: q overrun, queuing locally
   35. Jul 26 10:11:21 localhost pulseaudio[26721]: (51984.208|   0.029)
   asyncq.c: q overrun, queuing locally
   36. Jul 26 10:11:21 localhost pulseaudio[26721]: (51984.208|   0.000)
   asyncq.c: q overrun, queuing locally
   37. Jul 26 10:11:21 localhost pulseaudio[26721]: (51984.738|   0.530)
   alsa-sink.c: Increasing wakeup watermark to 130.11 ms
   38. Jul 26 10:11:25 localhost pulseaudio[26721]: (51988.239|   3.500)
   alsa-sink.c: Increasing wakeup watermark to 140.00 ms
