From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/3] Usage of AM_SILENT_RULES and small
 cleanup
Date: Wed, 30 Sep 2009 11:31:32 +0100
Message-ID: <1254306692.5786.30.camel@odin>
References: <1254260901-1161-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 14BC42437F
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 12:31:35 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so2336424fge.2
	for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2009 03:31:34 -0700 (PDT)
In-Reply-To: <1254260901-1161-1-git-send-email-stefan@datenfreihafen.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Schmidt <stefan@datenfreihafen.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2009-09-29 at 23:48 +0200, Stefan Schmidt wrote:
> Hello.
> 
> While working with alsa-lib to get scenarios in shape and submitted later I
> added support for the new automake feature AM_SILENT_RULES and did some small
> cleanups.
> 
> [PATCH 1/3] cvscompile: Remove in favour of gitcompile.
> I see no reason to keep this around when CVS is no longer used and gitcompile
> does replace it. Something I miss here?
> 
> [PATCH 2/3] configure.in: Add m4 check for new AM_SILENT_RULES
> The kbuild like output makes it a lot easier to follow the compile and linking
> process, at least in my opinion. It is available with automake 1.11 and we use a
> m4 macro here to only use it when it is available.
> 
> [PATCH 3/3] control: Remove unused variable.
> Found while really seeing what is going on thanks to AM_SILENT_RULES: ;)
> 

All Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Liam
