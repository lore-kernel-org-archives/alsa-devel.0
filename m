From: Josh Lehan <alsa@krellan.com>
Subject: Re: Newbie question: Sending untimed MIDI data to ALSA
 seq
Date: Wed, 13 Jan 2010 11:22:29 -0800
Message-ID: <4B4E1D75.2020602@krellan.com>
References: <4B490D93.1050506@krellan.com> <4B4C5F55.8010009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server3.hostdango.com (server3.hostdango.com [67.222.146.219])
	by alsa0.perex.cz (Postfix) with ESMTP id 11A48103852
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 20:22:31 +0100 (CET)
In-Reply-To: <4B4C5F55.8010009@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Josh Lehan <alsa@krellan.com>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Josh Lehan wrote:
>> I also looked at "amidi", which features a -S option to send in untimed
>> MIDI bytes, but unfortunately, that addresses an entirely different
>> namespace.  Evidently, it only speaks to "RawMIDI" devices, of which
>> TiMidity is not.
> 
> Try the snd-virmidi driver.  It is intended to make sequencer ports
> available as OSS midi devices, but you also get RawMIDI ports for free.

Thanks for the suggestion.  I looked into that kernel driver, but it's
not a full solution to the problem.  I have an idea for writing a little
ALSA program (in userspace) that will accept arbitrary bytes as input,
and feed it into the ALSA stack, so I'll work on that.  If I am
successful in getting that done, then it will be a really clean solution
to this problem.

Josh
