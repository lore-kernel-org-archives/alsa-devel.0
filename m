From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Fix jack creation for codecs
 with front and rear Line In
Date: Tue, 31 Jan 2012 11:18:38 +0100
Message-ID: <4F27BFFE.6090400@canonical.com>
References: <1327997055-7855-1-git-send-email-david.henningsson@canonical.com>
	<CAN8ccibRNQAEopWKYdifHcsa84xDYsbH6KmTUWiQrR7o0PvHNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 044DC2469D
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 11:18:39 +0100 (CET)
In-Reply-To: <CAN8ccibRNQAEopWKYdifHcsa84xDYsbH6KmTUWiQrR7o0PvHNA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/31/2012 09:29 AM, Raymond Yau wrote:
> 2012/1/31, David Henningsson<david.henningsson@canonical.com>:
>> If a codec has both a front and a rear Line In, two controls both
>> named "Line Jack" will be created, which causes parsing to fail.
>> While a long term solution might be to name the jacks differently,
>> this extra check is consistent with what is already being done in many
>> auto-parsers, and will also protect against other cases when two
>> inputs have the same label.
>>
>> BugLink: https://bugs.launchpad.net/bugs/923409
>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>> ---
>
> I have doubt since most of ad1988 6stack-dig quirks have two Line In (
> one is ext front and the other is int ATAPI and the "Input Source"
> controls are broken

Well, it won't fix any "Input Source" controls, of course. Only jack 
creation later, assuming you have your autocfg struct set up correctly.


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
