From: joy ping <joy@pingfm.org>
Subject: Re: What is the current status of the alsa sound server
 (signal polling)?
Date: Sat, 20 Apr 2002 00:05:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.40.0204200001530.5887-100000@ping01.stura.uni-weimar.de>
References: <20020419165711.C6B2C47B24@audio13.medien.uni-weimar.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ping01.stura.uni-weimar.de (postfix@ping01.stura.uni-weimar.de [141.54.160.24])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA11786
	for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2002 00:04:25 +0200
In-Reply-To: <20020419165711.C6B2C47B24@audio13.medien.uni-weimar.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Apr 2002, Paul Davis wrote:

> the term "polling" in not very useful here. all ALSA supported
> hardware can be "polled" in the sense that a program can stop and wait
> for it to be ready to read or write from. no hardware support over and
> above the minimum necessary for basic audio i/o is necessary for this.
>
> i think you're describing something that is generally known as
> "multi-open", in which the hardware supports multiple independent (but
> generally synchronous) streams of audio data to be possible, and each
> process that opens the device gets a new stream. the streams are mixed
> in hardware before being delivered to the physical outputs.
>
yes sorry i ment what i suppose he ment intentionally a kind of
"multi-open". maybe we can agree on this to call it multi-open-mode?


> i am not sure how "polling" (of any kind) relates to this. care to explain?
>
> --p
>
