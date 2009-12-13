From: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: Q: Why I do have to restart alsa everytime after a
	resume from disk/ram ? Is this alsa- or kernel or config related??
Date: Sun, 13 Dec 2009 15:27:48 -0800
Message-ID: <2c0942db0912131527x118f9689oe1dc128543f4fc27@mail.gmail.com>
References: <ffd8902a0912110121k795223ar6af644c41cd357b8@mail.gmail.com>
	<4B22DD11.7000905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f172.google.com (mail-iw0-f172.google.com
	[209.85.223.172])
	by alsa0.perex.cz (Postfix) with ESMTP id EB01D103812
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 00:28:09 +0100 (CET)
Received: by iwn2 with SMTP id 2so1683939iwn.16
	for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2009 15:28:08 -0800 (PST)
In-Reply-To: <4B22DD11.7000905@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: alsa-devel@alsa-project.org, Christian Hartmann <cornogle@googlemail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 11, 2009 at 4:00 PM, Robert Hancock <hancockrwd@gmail.com> wrote:
> On 12/11/2009 03:21 AM, Christian Hartmann wrote:
>>
>> hello list,
>>
>> everytime I suspended to disk or to ram, regardless of the used kernel
>> (git or stable from distri), I must restart alsa to hear sound again.
>> searched google and tried a lot but still the same awful behaviour.
>> Has anybode some suggestions for me? is this alsa related ? or is this
>> a kernel issue which could be dealt here?
>
> I'm not sure what you mean by restarting ALSA, do you mean reloading the
> audio device module or something?
>
> You didn't mention which kind of sound hardware you were using either..

Data point: Older versions of PulseAudio are very picky about the
timing data that comes back from ALSA, and throws a hissy-fit and goes
and sulks if it believes it's getting lied to. Perhaps you need to try
upgrading the PulseAudio packages, and try again.
