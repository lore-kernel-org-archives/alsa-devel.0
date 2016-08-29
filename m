From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: No sound for several minutes after reboot
Date: Mon, 29 Aug 2016 16:02:33 +0200
Message-ID: <20160829140233.GA857@x4>
References: <20160827113908.GA312@x4> <s5htwe4t2hy.wl-tiwai@suse.de>
 <20160829083334.GA309@x4> <s5hshtot1e2.wl-tiwai@suse.de>
 <20160829085653.GA306@x4> <20160829090548.GA314@x4>
 <s5hk2f0szne.wl-tiwai@suse.de> <20160829092047.GB314@x4>
 <s5hh9a3udhn.wl-tiwai@suse.de> <20160829120659.GA305@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.ud10.udmedia.de (ud10.udmedia.de [194.117.254.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 46ED3266957
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 18:29:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160829120659.GA305@x4>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2016.08.29 at 14:06 +0200, Markus Trippelsdorf wrote:
> On 2016.08.29 at 11:32 +0200, Takashi Iwai wrote:
> > On Mon, 29 Aug 2016 11:20:47 +0200,
> > Markus Trippelsdorf wrote:
> > > 
> > > On 2016.08.29 at 11:16 +0200, Takashi Iwai wrote:
> > > > On Mon, 29 Aug 2016 11:05:48 +0200,
> > > > Markus Trippelsdorf wrote:
> > > > > 
> > > > > On 2016.08.29 at 10:56 +0200, Markus Trippelsdorf wrote:
> > > > > > 
> > > > > > Unfortunately running: hda-verb /dev/snd/hwC0D0 0x14 SET_POWER 0x00
> > > > > > has no effect.
> > > > > 
> > > > > OK.
> > > > > Running: hda-verb /dev/snd/hwC0D0 0x15 SET_DIGI_CONVERT_1 0x01
> > > > > fixes the issue.
> > > > > I have now put this into my startup script.
> > > > 
> > > > Oh, then you're using SPDIF output or such?  I missed it from the
> > > > description.
> > > 
> > > Yes, as I wrote in first mail:
> > > it is a TOSLINK-S/PDIF link to my DAC.
> > 
> > Yeah, now I found it.  It's hidden well like Wally, as if it's a part
> > of the "aplay -l" output...
> > 
> > > > This should have been set by IEC958 status bits control.  Does the
> > > > problem exist only after a fresh reboot?
> > > 
> > > Yes. And only for a few minutes. After that it gets finally switched on.
> > 
> > Hm, it's interesting who sets this bit at all.  Could you track it via
> > tracing verbs as described in Documentation/sound/alsa/HD-Audio.txt.
> 
> Ok here it is:
> 
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 414/414   #P:4
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>  output:ALSA def-222   [002] d...    60.915790: snd_hdac_stream_stop: stream_tag: 5
>  output:ALSA def-222   [002] ....    61.623936: hda_send_cmd: [0000:00:14.2:0] val=0x012a0000
>  output:ALSA def-222   [002] ....    61.623999: hda_get_response: [0000:00:14.2:0] val=0x00004011
>  output:ALSA def-222   [002] d...    61.624097: snd_hdac_stream_start: stream_tag: 5
>  output:ALSA def-222   [002] d...    62.274462: snd_hdac_stream_stop: stream_tag: 5
>      kworker/1:5-72    [001] ....    64.698914: hda_send_cmd: [0000:01:05.1:0] val=0x00170503
>      kworker/1:5-72    [001] ....    64.698935: hda_get_response: [0000:01:05.1:0] val=0x00000000
>      kworker/1:5-72    [001] ....    64.698938: hda_send_cmd: [0000:01:05.1:0] val=0x001f0500
>      kworker/1:5-72    [001] ....    64.698951: hda_get_response: [0000:01:05.1:0] val=0x00000033
> 
> (Here I start and stop my media player a few times, but there is no sound)
> 
>  output:ALSA def-222   [002] ....    92.664711: hda_send_cmd: [0000:00:14.2:0] val=0x012a0000
>  output:ALSA def-222   [002] ....    92.664778: hda_get_response: [0000:00:14.2:0] val=0x00004011
>  output:ALSA def-222   [002] d...    92.664821: snd_hdac_stream_start: stream_tag: 5
>  output:ALSA def-222   [003] d...   101.396054: snd_hdac_stream_stop: stream_tag: 5
>  output:ALSA def-222   [003] ....   135.699370: hda_send_cmd: [0000:00:14.2:0] val=0x012a0000
>  output:ALSA def-222   [003] ....   135.699431: hda_get_response: [0000:00:14.2:0] val=0x00004011
>  output:ALSA def-222   [003] d...   135.699545: snd_hdac_stream_start: stream_tag: 5
>  output:ALSA def-222   [003] d...   136.442798: snd_hdac_stream_stop: stream_tag: 5
>  output:ALSA def-222   [003] ....   169.685030: hda_send_cmd: [0000:00:14.2:0] val=0x012a0000
>  output:ALSA def-222   [003] ....   169.685092: hda_get_response: [0000:00:14.2:0] val=0x00004011
>  output:ALSA def-222   [003] d...   169.685226: snd_hdac_stream_start: stream_tag: 5
>  output:ALSA def-222   [003] d...   170.521321: snd_hdac_stream_stop: stream_tag: 5
>  output:ALSA def-222   [003] ....   212.502634: hda_send_cmd: [0000:00:14.2:0] val=0x012a0000
>  output:ALSA def-222   [003] ....   212.502694: hda_get_response: [0000:00:14.2:0] val=0x00004011
>  output:ALSA def-222   [003] d...   212.502807: snd_hdac_stream_start: stream_tag: 5
>  output:ALSA def-222   [002] d...   214.360648: snd_hdac_stream_stop: stream_tag: 5
>  output:ALSA def-222   [002] ....   252.760870: hda_send_cmd: [0000:00:14.2:0] val=0x012a0000
>  output:ALSA def-222   [002] ....   252.760933: hda_get_response: [0000:00:14.2:0] val=0x00004011
>  output:ALSA def-222   [002] d...   252.761035: snd_hdac_stream_start: stream_tag: 5
>  output:ALSA def-222   [003] d...   254.525994: snd_hdac_stream_stop: stream_tag: 5
>  output:ALSA def-222   [000] ....   273.202336: hda_send_cmd: [0000:00:14.2:0] val=0x012a0000
>  output:ALSA def-222   [000] ....   273.202400: hda_get_response: [0000:00:14.2:0] val=0x00004011
>  output:ALSA def-222   [000] d...   273.202499: snd_hdac_stream_start: stream_tag: 5
>  output:ALSA def-222   [003] d...   273.945690: snd_hdac_stream_stop: stream_tag: 5
>  
>  (After the kworker is finished, sound is OK again)
> 
>      kworker/1:5-72    [001] ....   335.961882: hda_send_cmd: [0000:00:14.2:0] val=0x01270600
>      kworker/1:5-72    [001] ....   335.961946: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   335.961948: hda_send_cmd: [0000:00:14.2:0] val=0x01220000
>      kworker/1:5-72    [001] ....   335.962007: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   335.962009: hda_send_cmd: [0000:00:14.2:0] val=0x01570600
>      kworker/1:5-72    [001] ....   335.962065: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   335.962067: hda_send_cmd: [0000:00:14.2:0] val=0x01520000
>      kworker/1:5-72    [001] ....   335.962128: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.068516: hda_send_cmd: [0000:00:14.2:0] val=0x00170503
>      kworker/1:5-72    [001] ....   336.068577: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.068581: hda_send_cmd: [0000:00:14.2:0] val=0x01070503
>      kworker/1:5-72    [001] ....   336.068633: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.068635: hda_send_cmd: [0000:00:14.2:0] val=0x01170503
>      kworker/1:5-72    [001] ....   336.068695: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.068697: hda_send_cmd: [0000:00:14.2:0] val=0x01270503
>      kworker/1:5-72    [001] ....   336.068758: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.068759: hda_send_cmd: [0000:00:14.2:0] val=0x01370503
>      kworker/1:5-72    [001] ....   336.068821: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.068822: hda_send_cmd: [0000:00:14.2:0] val=0x01470503
>      kworker/1:5-72    [001] ....   336.068883: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.068884: hda_send_cmd: [0000:00:14.2:0] val=0x01570503
>      kworker/1:5-72    [001] ....   336.068945: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.068947: hda_send_cmd: [0000:00:14.2:0] val=0x01670503
>      kworker/1:5-72    [001] ....   336.069008: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069010: hda_send_cmd: [0000:00:14.2:0] val=0x01770503
>      kworker/1:5-72    [001] ....   336.069070: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069072: hda_send_cmd: [0000:00:14.2:0] val=0x01870503
>      kworker/1:5-72    [001] ....   336.069133: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069134: hda_send_cmd: [0000:00:14.2:0] val=0x01970503
>      kworker/1:5-72    [001] ....   336.069195: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069197: hda_send_cmd: [0000:00:14.2:0] val=0x01a70503
>      kworker/1:5-72    [001] ....   336.069259: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069260: hda_send_cmd: [0000:00:14.2:0] val=0x01b70503
>      kworker/1:5-72    [001] ....   336.069320: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069322: hda_send_cmd: [0000:00:14.2:0] val=0x01c70503
>      kworker/1:5-72    [001] ....   336.069383: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069384: hda_send_cmd: [0000:00:14.2:0] val=0x01d70503
>      kworker/1:5-72    [001] ....   336.069445: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069447: hda_send_cmd: [0000:00:14.2:0] val=0x01e70503
>      kworker/1:5-72    [001] ....   336.069508: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069509: hda_send_cmd: [0000:00:14.2:0] val=0x01f70503
>      kworker/1:5-72    [001] ....   336.069570: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069572: hda_send_cmd: [0000:00:14.2:0] val=0x02070503
>      kworker/1:5-72    [001] ....   336.069633: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069634: hda_send_cmd: [0000:00:14.2:0] val=0x02170503
>      kworker/1:5-72    [001] ....   336.069696: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069697: hda_send_cmd: [0000:00:14.2:0] val=0x02270503
>      kworker/1:5-72    [001] ....   336.069758: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069759: hda_send_cmd: [0000:00:14.2:0] val=0x02370503
>      kworker/1:5-72    [001] ....   336.069821: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069822: hda_send_cmd: [0000:00:14.2:0] val=0x02470503
>      kworker/1:5-72    [001] ....   336.069883: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069885: hda_send_cmd: [0000:00:14.2:0] val=0x02570503
>      kworker/1:5-72    [001] ....   336.069945: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.069947: hda_send_cmd: [0000:00:14.2:0] val=0x02670503
>      kworker/1:5-72    [001] ....   336.070008: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.070009: hda_send_cmd: [0000:00:14.2:0] val=0x02770503
>      kworker/1:5-72    [001] ....   336.070070: hda_get_response: [0000:00:14.2:0] val=0x00000000
>      kworker/1:5-72    [001] ....   336.070072: hda_send_cmd: [0000:00:14.2:0] val=0x001f0500
>      kworker/1:5-72    [001] ....   336.070133: hda_get_response: [0000:00:14.2:0] val=0x00000033
>  output:ALSA def-222   [003] ....   422.015818: hda_send_cmd: [0000:00:14.2:0] val=0x00170500
>  output:ALSA def-222   [003] ....   422.015877: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.015892: hda_send_cmd: [0000:00:14.2:0] val=0x01070500
>  output:ALSA def-222   [003] ....   422.015935: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.015937: hda_send_cmd: [0000:00:14.2:0] val=0x01170500
>  output:ALSA def-222   [003] ....   422.015997: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016000: hda_send_cmd: [0000:00:14.2:0] val=0x01270500
>  output:ALSA def-222   [003] ....   422.016060: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016062: hda_send_cmd: [0000:00:14.2:0] val=0x01370500
>  output:ALSA def-222   [003] ....   422.016122: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016124: hda_send_cmd: [0000:00:14.2:0] val=0x01470503
>  output:ALSA def-222   [003] ....   422.016164: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016166: hda_send_cmd: [0000:00:14.2:0] val=0x01570500
>  output:ALSA def-222   [003] ....   422.016206: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016207: hda_send_cmd: [0000:00:14.2:0] val=0x01670500
>  output:ALSA def-222   [003] ....   422.016248: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016250: hda_send_cmd: [0000:00:14.2:0] val=0x01770500
>  output:ALSA def-222   [003] ....   422.016310: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016311: hda_send_cmd: [0000:00:14.2:0] val=0x01870500
>  output:ALSA def-222   [003] ....   422.016352: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016353: hda_send_cmd: [0000:00:14.2:0] val=0x01970500
>  output:ALSA def-222   [003] ....   422.016393: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016395: hda_send_cmd: [0000:00:14.2:0] val=0x01a70500
>  output:ALSA def-222   [003] ....   422.016456: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016458: hda_send_cmd: [0000:00:14.2:0] val=0x01b70500
>  output:ALSA def-222   [003] ....   422.016497: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016499: hda_send_cmd: [0000:00:14.2:0] val=0x01c70500
>  output:ALSA def-222   [003] ....   422.016539: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016540: hda_send_cmd: [0000:00:14.2:0] val=0x01d70500
>  output:ALSA def-222   [003] ....   422.016581: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016583: hda_send_cmd: [0000:00:14.2:0] val=0x01e70500
>  output:ALSA def-222   [003] ....   422.016643: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016645: hda_send_cmd: [0000:00:14.2:0] val=0x01f70500
>  output:ALSA def-222   [003] ....   422.016685: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016687: hda_send_cmd: [0000:00:14.2:0] val=0x02070500
>  output:ALSA def-222   [003] ....   422.016727: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016729: hda_send_cmd: [0000:00:14.2:0] val=0x02170500
>  output:ALSA def-222   [003] ....   422.016789: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016791: hda_send_cmd: [0000:00:14.2:0] val=0x02270500
>  output:ALSA def-222   [003] ....   422.016831: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016832: hda_send_cmd: [0000:00:14.2:0] val=0x02370500
>  output:ALSA def-222   [003] ....   422.016872: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016874: hda_send_cmd: [0000:00:14.2:0] val=0x02470500
>  output:ALSA def-222   [003] ....   422.016914: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016916: hda_send_cmd: [0000:00:14.2:0] val=0x02570500
>  output:ALSA def-222   [003] ....   422.016956: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016957: hda_send_cmd: [0000:00:14.2:0] val=0x02670500
>  output:ALSA def-222   [003] ....   422.016998: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.016999: hda_send_cmd: [0000:00:14.2:0] val=0x02770500
>  output:ALSA def-222   [003] ....   422.017039: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.017041: hda_send_cmd: [0000:00:14.2:0] val=0x001f0500
>  output:ALSA def-222   [003] ....   422.017081: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.031386: hda_send_cmd: [0000:00:14.2:0] val=0x001f9801
>  output:ALSA def-222   [003] ....   422.031437: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.031438: hda_send_cmd: [0000:00:14.2:0] val=0x001f88c0
>  output:ALSA def-222   [003] ....   422.031498: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.031500: hda_send_cmd: [0000:00:14.2:0] val=0x001f73e1
>  output:ALSA def-222   [003] ....   422.031561: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.031568: hda_send_cmd: [0000:00:14.2:0] val=0x01c70740
>  output:ALSA def-222   [003] ....   422.031623: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.031626: hda_send_cmd: [0000:00:14.2:0] val=0x010f0500
>  output:ALSA def-222   [003] ....   422.031686: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.031687: hda_send_cmd: [0000:00:14.2:0] val=0x016f0500
>  output:ALSA def-222   [003] ....   422.031727: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.031729: hda_send_cmd: [0000:00:14.2:0] val=0x01cf0500
>  output:ALSA def-222   [003] ....   422.031769: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.031808: hda_send_cmd: [0000:00:14.2:0] val=0x01c70c02
>  output:ALSA def-222   [003] ....   422.031852: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.031855: hda_send_cmd: [0000:00:14.2:0] val=0x01970740
>  output:ALSA def-222   [003] ....   422.031915: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.031916: hda_send_cmd: [0000:00:14.2:0] val=0x011f0500
>  output:ALSA def-222   [003] ....   422.031957: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.031958: hda_send_cmd: [0000:00:14.2:0] val=0x018f0500
>  output:ALSA def-222   [003] ....   422.031998: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032000: hda_send_cmd: [0000:00:14.2:0] val=0x019f0500
>  output:ALSA def-222   [003] ....   422.032040: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032061: hda_send_cmd: [0000:00:14.2:0] val=0x02270740
>  output:ALSA def-222   [003] ....   422.032102: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032104: hda_send_cmd: [0000:00:14.2:0] val=0x024f0500
>  output:ALSA def-222   [003] ....   422.032144: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032146: hda_send_cmd: [0000:00:14.2:0] val=0x026f0500
>  output:ALSA def-222   [003] ....   422.032186: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032187: hda_send_cmd: [0000:00:14.2:0] val=0x022f0500
>  output:ALSA def-222   [003] ....   422.032228: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032248: hda_send_cmd: [0000:00:14.2:0] val=0x02370740
>  output:ALSA def-222   [003] ....   422.032290: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032292: hda_send_cmd: [0000:00:14.2:0] val=0x025f0500
>  output:ALSA def-222   [003] ....   422.032352: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032354: hda_send_cmd: [0000:00:14.2:0] val=0x027f0500
>  output:ALSA def-222   [003] ....   422.032394: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032395: hda_send_cmd: [0000:00:14.2:0] val=0x023f0500
>  output:ALSA def-222   [003] ....   422.032436: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032457: hda_send_cmd: [0000:00:14.2:0] val=0x01d707c0
>  output:ALSA def-222   [003] ....   422.032498: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032500: hda_send_cmd: [0000:00:14.2:0] val=0x010f0500
>  output:ALSA def-222   [003] ....   422.032540: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032541: hda_send_cmd: [0000:00:14.2:0] val=0x016f0500
>  output:ALSA def-222   [003] ....   422.032581: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032583: hda_send_cmd: [0000:00:14.2:0] val=0x01df0500
>  output:ALSA def-222   [003] ....   422.032624: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032626: hda_send_cmd: [0000:00:14.2:0] val=0x01d70100
>  output:ALSA def-222   [003] ....   422.032686: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032718: hda_send_cmd: [0000:00:14.2:0] val=0x01a70721
>  output:ALSA def-222   [003] ....   422.032769: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032771: hda_send_cmd: [0000:00:14.2:0] val=0x01af0500
>  output:ALSA def-222   [003] ....   422.032832: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032834: hda_send_cmd: [0000:00:14.2:0] val=0x016f0500
>  output:ALSA def-222   [003] ....   422.032894: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032920: hda_send_cmd: [0000:00:14.2:0] val=0x01e70721
>  output:ALSA def-222   [003] ....   422.032978: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.032979: hda_send_cmd: [0000:00:14.2:0] val=0x01ef0500
>  output:ALSA def-222   [003] ....   422.033019: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033020: hda_send_cmd: [0000:00:14.2:0] val=0x016f0500
>  output:ALSA def-222   [003] ....   422.033061: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033088: hda_send_cmd: [0000:00:14.2:0] val=0x01b70720
>  output:ALSA def-222   [003] ....   422.033144: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033146: hda_send_cmd: [0000:00:14.2:0] val=0x01bf0500
>  output:ALSA def-222   [003] ....   422.033186: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033187: hda_send_cmd: [0000:00:14.2:0] val=0x016f0500
>  output:ALSA def-222   [003] ....   422.033227: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033250: hda_send_cmd: [0000:00:14.2:0] val=0x01f70720
>  output:ALSA def-222   [003] ....   422.033290: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033292: hda_send_cmd: [0000:00:14.2:0] val=0x01ff0500
>  output:ALSA def-222   [003] ....   422.033332: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033333: hda_send_cmd: [0000:00:14.2:0] val=0x016f0500
>  output:ALSA def-222   [003] ....   422.033373: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033395: hda_send_cmd: [0000:00:14.2:0] val=0x01af0500
>  output:ALSA def-222   [003] ....   422.033436: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033438: hda_send_cmd: [0000:00:14.2:0] val=0x017f0500
>  output:ALSA def-222   [003] ....   422.033477: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033479: hda_send_cmd: [0000:00:14.2:0] val=0x013f0500
>  output:ALSA def-222   [003] ....   422.033519: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033524: hda_send_cmd: [0000:00:14.2:0] val=0x01770101
>  output:ALSA def-222   [003] ....   422.033582: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033616: hda_send_cmd: [0000:00:14.2:0] val=0x02070740
>  output:ALSA def-222   [003] ....   422.033665: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033667: hda_send_cmd: [0000:00:14.2:0] val=0x012f0500
>  output:ALSA def-222   [003] ....   422.033707: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033708: hda_send_cmd: [0000:00:14.2:0] val=0x020f0500
>  output:ALSA def-222   [003] ....   422.033748: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033751: hda_send_cmd: [0000:00:14.2:0] val=0x02170740
>  output:ALSA def-222   [003] ....   422.033811: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033813: hda_send_cmd: [0000:00:14.2:0] val=0x015f0500
>  output:ALSA def-222   [003] ....   422.033852: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033854: hda_send_cmd: [0000:00:14.2:0] val=0x021f0500
>  output:ALSA def-222   [003] ....   422.033894: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033914: hda_send_cmd: [0000:00:14.2:0] val=0x01df0900
>  output:ALSA def-222   [003] ....   422.033956: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.033960: hda_send_cmd: [0000:00:14.2:0] val=0x01d707c0
>  output:ALSA def-222   [003] ....   422.034019: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034022: hda_send_cmd: [0000:00:14.2:0] val=0x01c70740
>  output:ALSA def-222   [003] ....   422.034082: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034084: hda_send_cmd: [0000:00:14.2:0] val=0x01c70c02
>  output:ALSA def-222   [003] ....   422.034144: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034146: hda_send_cmd: [0000:00:14.2:0] val=0x01970740
>  output:ALSA def-222   [003] ....   422.034186: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034189: hda_send_cmd: [0000:00:14.2:0] val=0x02270740
>  output:ALSA def-222   [003] ....   422.034249: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034251: hda_send_cmd: [0000:00:14.2:0] val=0x02370740
>  output:ALSA def-222   [003] ....   422.034311: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034314: hda_send_cmd: [0000:00:14.2:0] val=0x01cf0900
>  output:ALSA def-222   [003] ....   422.034373: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034376: hda_send_cmd: [0000:00:14.2:0] val=0x019f0900
>  output:ALSA def-222   [003] ....   422.034436: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034438: hda_send_cmd: [0000:00:14.2:0] val=0x022f0900
>  output:ALSA def-222   [003] ....   422.034498: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034500: hda_send_cmd: [0000:00:14.2:0] val=0x023f0900
>  output:ALSA def-222   [003] ....   422.034561: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034564: hda_send_cmd: [0000:00:14.2:0] val=0x01039000
>  output:ALSA def-222   [003] ....   422.034624: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034626: hda_send_cmd: [0000:00:14.2:0] val=0x0103a000
>  output:ALSA def-222   [003] ....   422.034686: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034688: hda_send_cmd: [0000:00:14.2:0] val=0x01139026
>  output:ALSA def-222   [003] ....   422.034748: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034750: hda_send_cmd: [0000:00:14.2:0] val=0x0113a026
>  output:ALSA def-222   [003] ....   422.034790: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034793: hda_send_cmd: [0000:00:14.2:0] val=0x01270d01
>  output:ALSA def-222   [003] ....   422.034853: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034854: hda_send_cmd: [0000:00:14.2:0] val=0x01270e00
>  output:ALSA def-222   [003] ....   422.034894: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034896: hda_send_cmd: [0000:00:14.2:0] val=0x01335000
>  output:ALSA def-222   [003] ....   422.034956: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.034958: hda_send_cmd: [0000:00:14.2:0] val=0x01336000
>  output:ALSA def-222   [003] ....   422.034999: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035002: hda_send_cmd: [0000:00:14.2:0] val=0x01570d01
>  output:ALSA def-222   [003] ....   422.035061: hda_get_response: [0000:00:14.2:0] val=0x00000000

Actually it right here that sound starts again:

markus@x4 hda-emu % ./a.out 0x01570d01
raw value = 0x01570d01
cid = 0, nid = 0x15, verb = 0x70d, parm = 0x01
raw value: verb = 0x70d, parm = 0x1
verbname = set_digi_cvt_1

>  output:ALSA def-222   [003] ....   422.035062: hda_send_cmd: [0000:00:14.2:0] val=0x01570e00
>  output:ALSA def-222   [003] ....   422.035102: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035104: hda_send_cmd: [0000:00:14.2:0] val=0x01635017
>  output:ALSA def-222   [003] ....   422.035144: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035147: hda_send_cmd: [0000:00:14.2:0] val=0x01635199
>  output:ALSA def-222   [003] ....   422.035207: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035209: hda_send_cmd: [0000:00:14.2:0] val=0x01635280
>  output:ALSA def-222   [003] ....   422.035249: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035251: hda_send_cmd: [0000:00:14.2:0] val=0x01635380
>  output:ALSA def-222   [003] ....   422.035311: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035313: hda_send_cmd: [0000:00:14.2:0] val=0x01635480
>  output:ALSA def-222   [003] ....   422.035353: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035355: hda_send_cmd: [0000:00:14.2:0] val=0x01635580
>  output:ALSA def-222   [003] ....   422.035415: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035417: hda_send_cmd: [0000:00:14.2:0] val=0x01635680
>  output:ALSA def-222   [003] ....   422.035460: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035462: hda_send_cmd: [0000:00:14.2:0] val=0x01636017
>  output:ALSA def-222   [003] ....   422.035519: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035521: hda_send_cmd: [0000:00:14.2:0] val=0x01636199
>  output:ALSA def-222   [003] ....   422.035582: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035583: hda_send_cmd: [0000:00:14.2:0] val=0x01636280
>  output:ALSA def-222   [003] ....   422.035623: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035625: hda_send_cmd: [0000:00:14.2:0] val=0x01636380
>  output:ALSA def-222   [003] ....   422.035665: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035667: hda_send_cmd: [0000:00:14.2:0] val=0x01636480
>  output:ALSA def-222   [003] ....   422.035707: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035709: hda_send_cmd: [0000:00:14.2:0] val=0x01636580
>  output:ALSA def-222   [003] ....   422.035769: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035771: hda_send_cmd: [0000:00:14.2:0] val=0x01636680
>  output:ALSA def-222   [003] ....   422.035811: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035813: hda_send_cmd: [0000:00:14.2:0] val=0x01770101
>  output:ALSA def-222   [003] ....   422.035874: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035876: hda_send_cmd: [0000:00:14.2:0] val=0x01839080
>  output:ALSA def-222   [003] ....   422.035936: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.035938: hda_send_cmd: [0000:00:14.2:0] val=0x0183a080
>  output:ALSA def-222   [003] ....   422.035998: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036001: hda_send_cmd: [0000:00:14.2:0] val=0x01970740
>  output:ALSA def-222   [003] ....   422.036061: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036063: hda_send_cmd: [0000:00:14.2:0] val=0x01970882
>  output:ALSA def-222   [003] ....   422.036103: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036104: hda_send_cmd: [0000:00:14.2:0] val=0x01a35000
>  output:ALSA def-222   [003] ....   422.036144: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036146: hda_send_cmd: [0000:00:14.2:0] val=0x01a36000
>  output:ALSA def-222   [003] ....   422.036186: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036188: hda_send_cmd: [0000:00:14.2:0] val=0x01a70721
>  output:ALSA def-222   [003] ....   422.036248: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036251: hda_send_cmd: [0000:00:14.2:0] val=0x01a70886
>  output:ALSA def-222   [003] ....   422.036311: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036313: hda_send_cmd: [0000:00:14.2:0] val=0x01b70720
>  output:ALSA def-222   [003] ....   422.036352: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036354: hda_send_cmd: [0000:00:14.2:0] val=0x01b70888
>  output:ALSA def-222   [003] ....   422.036394: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036396: hda_send_cmd: [0000:00:14.2:0] val=0x01c39080
>  output:ALSA def-222   [003] ....   422.036436: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036438: hda_send_cmd: [0000:00:14.2:0] val=0x01c3a080
>  output:ALSA def-222   [003] ....   422.036498: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036501: hda_send_cmd: [0000:00:14.2:0] val=0x01c70740
>  output:ALSA def-222   [003] ....   422.036561: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036563: hda_send_cmd: [0000:00:14.2:0] val=0x01c70881
>  output:ALSA def-222   [003] ....   422.036602: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036605: hda_send_cmd: [0000:00:14.2:0] val=0x01c70c02
>  output:ALSA def-222   [003] ....   422.036665: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036667: hda_send_cmd: [0000:00:14.2:0] val=0x01d39080
>  output:ALSA def-222   [003] ....   422.036707: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036708: hda_send_cmd: [0000:00:14.2:0] val=0x01d3a080
>  output:ALSA def-222   [003] ....   422.036748: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036751: hda_send_cmd: [0000:00:14.2:0] val=0x01d70100
>  output:ALSA def-222   [003] ....   422.036811: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036813: hda_send_cmd: [0000:00:14.2:0] val=0x01d707c0
>  output:ALSA def-222   [003] ....   422.036873: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036875: hda_send_cmd: [0000:00:14.2:0] val=0x01d70885
>  output:ALSA def-222   [003] ....   422.036915: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036917: hda_send_cmd: [0000:00:14.2:0] val=0x01e35000
>  output:ALSA def-222   [003] ....   422.036957: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.036959: hda_send_cmd: [0000:00:14.2:0] val=0x01e36000
>  output:ALSA def-222   [003] ....   422.037019: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037021: hda_send_cmd: [0000:00:14.2:0] val=0x01e70721
>  output:ALSA def-222   [003] ....   422.037082: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037083: hda_send_cmd: [0000:00:14.2:0] val=0x01e70887
>  output:ALSA def-222   [003] ....   422.037123: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037125: hda_send_cmd: [0000:00:14.2:0] val=0x01f70720
>  output:ALSA def-222   [003] ....   422.037165: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037168: hda_send_cmd: [0000:00:14.2:0] val=0x02070740
>  output:ALSA def-222   [003] ....   422.037228: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037230: hda_send_cmd: [0000:00:14.2:0] val=0x02170740
>  output:ALSA def-222   [003] ....   422.037290: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037292: hda_send_cmd: [0000:00:14.2:0] val=0x02270740
>  output:ALSA def-222   [003] ....   422.037353: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037355: hda_send_cmd: [0000:00:14.2:0] val=0x02270883
>  output:ALSA def-222   [003] ....   422.037415: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037417: hda_send_cmd: [0000:00:14.2:0] val=0x02370740
>  output:ALSA def-222   [003] ....   422.037478: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037479: hda_send_cmd: [0000:00:14.2:0] val=0x02370884
>  output:ALSA def-222   [003] ....   422.037519: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037521: hda_send_cmd: [0000:00:14.2:0] val=0x02439026
>  output:ALSA def-222   [003] ....   422.037561: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037563: hda_send_cmd: [0000:00:14.2:0] val=0x0243a026
>  output:ALSA def-222   [003] ....   422.037624: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037626: hda_send_cmd: [0000:00:14.2:0] val=0x02539026
>  output:ALSA def-222   [003] ....   422.037686: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037688: hda_send_cmd: [0000:00:14.2:0] val=0x0253a026
>  output:ALSA def-222   [003] ....   422.037727: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037730: hda_send_cmd: [0000:00:14.2:0] val=0x02639080
>  output:ALSA def-222   [003] ....   422.037790: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037792: hda_send_cmd: [0000:00:14.2:0] val=0x0263a080
>  output:ALSA def-222   [003] ....   422.037832: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037834: hda_send_cmd: [0000:00:14.2:0] val=0x02739080
>  output:ALSA def-222   [003] ....   422.037894: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037896: hda_send_cmd: [0000:00:14.2:0] val=0x0273a080
>  output:ALSA def-222   [003] ....   422.037936: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.037941: hda_send_cmd: [0000:00:14.2:0] val=0x01af0900
>  output:ALSA def-222   [003] ....   422.037998: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.038000: hda_send_cmd: [0000:00:14.2:0] val=0x01ef0900
>  output:ALSA def-222   [003] ....   422.038040: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.038042: hda_send_cmd: [0000:00:14.2:0] val=0x01bf0900
>  output:ALSA def-222   [003] ....   422.038082: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.038376: hda_send_cmd: [0000:00:14.2:0] val=0x012a0000
>  output:ALSA def-222   [003] ....   422.038437: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.038440: hda_send_cmd: [0000:00:14.2:0] val=0x012f0600
>  output:ALSA def-222   [003] ....   422.038499: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.038500: hda_send_cmd: [0000:00:14.2:0] val=0x01270650
>  output:ALSA def-222   [003] ....   422.038540: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.038542: hda_send_cmd: [0000:00:14.2:0] val=0x012a0000
>  output:ALSA def-222   [003] ....   422.038582: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.048012: hda_send_cmd: [0000:00:14.2:0] val=0x01224011
>  output:ALSA def-222   [003] ....   422.048061: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.048061: hda_send_cmd: [0000:00:14.2:0] val=0x015f0600
>  output:ALSA def-222   [003] ....   422.048102: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.048103: hda_send_cmd: [0000:00:14.2:0] val=0x01570650
>  output:ALSA def-222   [003] ....   422.048143: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.048144: hda_send_cmd: [0000:00:14.2:0] val=0x015a0000
>  output:ALSA def-222   [003] ....   422.048185: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] ....   422.058042: hda_send_cmd: [0000:00:14.2:0] val=0x01524011
>  output:ALSA def-222   [003] ....   422.058104: hda_get_response: [0000:00:14.2:0] val=0x00000000
>  output:ALSA def-222   [003] d...   422.058244: snd_hdac_stream_start: stream_tag: 5
> 
> -- 
> Markus

-- 
Markus
