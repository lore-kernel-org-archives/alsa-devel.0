From: Jason Mancine <jason@mancine.net>
Subject: Re: Zoom R16
Date: Fri, 22 Nov 2013 20:31:10 +0000 (UTC)
Message-ID: <loom.20131122T212507-512@post.gmane.org>
References: <CAPrbH=vnQ-xXsRDoj30nra7hB_hDEaF6u3ov0XuDG_ZpFzb3bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id D358426517E
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 21:35:05 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1VjxRQ-0007Qi-AC
 for alsa-devel@alsa-project.org; Fri, 22 Nov 2013 21:35:04 +0100
Received: from bb-205-209-90-54.gwi.net ([205.209.90.54])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 21:35:04 +0100
Received: from jason by bb-205-209-90-54.gwi.net with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 21:35:04 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Well, I solved part of my own problem -- by removing the .endpoint and 
.ep_addr settings from the quirk it now works for capture under .ifnum=1. In 
fact, I now see the interface in JACK listed as hw:R16(#1) which it never 
had done before. 

MIDI is also working properly on .ifnum=3

So, I am now certain that interface 2 is playback...  however, playback does 
not work with the following:

{ 
                                .ifnum = 2, 
                                .type = QUIRK_AUDIO_FIXED_ENDPOINT, 
                                .data = & (const struct audioformat) { 
                                        .formats = SNDRV_PCM_FMTBIT_S24_LE, 
                                        .channels = 2, 
                                        .iface = 1, 
                                        .altsetting = 1, 
                                        .altset_idx = 1, 
                                        .attributes = 
UAC_EP_CS_ATTR_SAMPLE_RATE, 
                                        .rates = SNDRV_PCM_RATE_44100 | 
                                                 SNDRV_PCM_RATE_48000 | 
                                                 SNDRV_PCM_RATE_88200 | 
                                                 SNDRV_PCM_RATE_96000, 
                                        .rate_min = 44100, 
                                        .rate_max = 96000, 
                                        .nr_rates = 4, 
                                        .rate_table = (unsigned int[]) { 
                                                        44100, 48000, 88200, 
96000 
                                        } 
                                } 
                        }, 


This totally freezes the computer...  I am certain that the device is 24 
bit, supports all four sample rates, and is capable of full duplex 
operation.  Any suggestions for this playback section?

Thanks,
Jason
