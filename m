From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Userspace drivers
Date: Thu, 27 Sep 2007 14:54:38 +0200
Message-ID: <46FBA80E.7010004@keyaccess.nl>
References: <6cc714350709261228v519ab4dcx657969fd07f022b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AAE624493
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Sep 2007 14:54:46 +0200 (CEST)
In-Reply-To: <6cc714350709261228v519ab4dcx657969fd07f022b0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Josh Litherland <josh@temp123.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/26/2007 09:28 PM, Josh Litherland wrote:

> Is there any facility for developing an ALSA device driver in userspace?
> I'm particularly interested in mixer devices; my goal is to expose the
> Thinkpad hardware volume buttons as an ALSA mixer.
> 
> Thanks for any pointers!

Most of the cheaper hardware today does volume control in software which 
ALSA supports through the softvol plugin that runs in userspace. I've never 
actually owned any of this hardware but assuming the volume control shows up 
in say alsamixer same as if it had been a hardware control, you'd have an 
example of a userspace volume control there. Actually talking to the buttons 
is another matter ofcourse but it may serve as a useful example of how to 
expose the control through alsa at least.

Or not, comments obviously welcome -- never look at it but also have a use 
in mind...

Rene.
