From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] alsamixer
Date: Wed, 28 May 2003 11:05:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305281104260.12323-100000@pnote.perex-int.cz>
References: <20030528012634.3430.h004.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030528012634.3430.h004.c012.wm@mail.icqmail.com.criticalpath.net>
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

On Wed, 28 May 2003, Eliot Blennerhassett wrote:

> On 28 May 2003 at 9:25, Jaroslav Kysela wrote:
> 
> > On Tue, 27 May 2003, Eliot Blennerhassett wrote:
> > 
> > > this patch enables alsamixer to adjust controls correctly where the min
> value is
> > > negative (non-zero?)
> > > 
> > > I have tested with my controls that have ranges of -100,0 and -10,22 and it
> > > seems to work OK.
> > 
> > It seems that only removal of condition 'if volume >= 0' is sufficient.
> Jaroslav,
> 
> I think the other change is necessary too.
> 
> Mixer conv returns a value between min and max.  Input vol1 is the percentage
> step.  In existing code returned vol1 is assumed to be that step converted into
> the units of the control.  When min is non-zero this is not true.\
> For example mixer_conv(2,0,100,-100,0) returns -98
> Subtracting min==-100 gives the correct result of (-98 -(-100))=+2
> I suspect that every control except mine has min==0
>  
>        vol1 = mixer_conv(vol1, 0, 100, min, max);
> +    vol1 -= min; // convert value to a delta in units of the volume control.
>       if (vol1 <= 0)

Yes, you're right. Fixed in CVS.

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
