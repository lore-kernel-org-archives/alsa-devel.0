From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] alsamixer
Date: Wed, 28 May 2003 09:25:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305280924140.12323-100000@pnote.perex-int.cz>
References: <20030527203635.27840.h002.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030527203635.27840.h002.c012.wm@mail.icqmail.com.criticalpath.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eliot Blennerhassett <bigblen@icqmail.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 27 May 2003, Eliot Blennerhassett wrote:

> this patch enables alsamixer to adjust controls correctly where the min value is
> negative (non-zero?)
> 
> I have tested with my controls that have ranges of -100,0 and -10,22 and it
> seems to work OK.

It seems that only removal of condition 'if volume >= 0' is sufficient.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
