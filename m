From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Recording sound from microphone isn't good working
 that playback sound is distortion.
Date: Sat, 4 Aug 2012 01:10:59 +0100
Message-ID: <20120804001059.GA30471@sirena.org.uk>
References: <201207311500149537558@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2388E265254
 for <alsa-devel@alsa-project.org>; Sat,  4 Aug 2012 02:11:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201207311500149537558@163.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiaoyong Wen <wen_kernel@163.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-kernel-cn <kernel@vger.linux-kernel.cn>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 31, 2012 at 03:00:16PM +0800, Xiaoyong Wen wrote:

> 		 3. Recording sound from microphone isn't good working that playback sound is distortion. 
> 		 #arecord -D 'hw:0,0' -r 48000 -f S16_LE -c 2 | aplay -D 'hw:0,0' -c 2 &
> 		 or
> 		 #arecord -d 10 -fdat test2.wav
> 		 I hear the sound is very distortion and low.
> 	     ~~~~~~~~~~~~~~~~~~~~~~~~~~
> 		 If I excute "amixer cset numid=9 3; amixer cset numid=7 31; amixer cset numid=87 on; amixer cset numid=6 31,31" command, and then volume is high.

This sounds fairly normal - microphones do need quite a bit of gain
applying to get useful signals.  I don't know what controls those are
(the control names are much more useful, the numids do change between
boards) but I would expect that microphone configuration wouldn't be
ideal out of the box and would need some tuning for your system.
