From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Userspace drivers
Date: Wed, 26 Sep 2007 18:35:30 -0700
Message-ID: <1190856930.30667.122.camel@razman.gruemaster.com>
References: <6cc714350709261228v519ab4dcx657969fd07f022b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A423244F3
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Sep 2007 03:35:32 +0200 (CEST)
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

On Wed, 2007-09-26 at 15:28 -0400, Josh Litherland wrote:

> Is there any facility for developing an ALSA device driver in
> userspace?  I'm particularly interested in mixer devices; my goal is
> to expose the Thinkpad hardware volume buttons as an ALSA mixer.
> 
> Thanks for any pointers!
> 


The volume buttons should be supported by either acpi controls or
keyboard settings.  Try running showkey and seeing if they trigger
keycodes.  Once you have those, you could map them to a macro that
adjusts volume through amixer.  I know that there are applets for KDE to
support the thinkpad keys, there may be others as well.


-- 
Tobin Davis  


Today's weirdness is tomorrow's reason why.
		-- Hunter S. Thompson
