From: Tarragon Allen <lists@n12turbo.com>
Subject: Re: ALSA + jack + xrun = kernel crash
Date: Thu, 22 May 2003 09:50:59 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305220950.59394.lists@n12turbo.com>
References: <s5hk7ckvbap.wl@alsa2.suse.de> <3ECBCF5B.2020807@esat.kuleuven.ac.be> <3ECC06D7.1030202@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3ECC06D7.1030202@student.kuleuven.ac.be>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 22 May 2003 09:08, Pieter Palmers wrote:
> Pieter Palmers wrote:
> >> ok.
> >>
> >> meanwhile, i committed my fixes (without the self_group change) to cvs
> >> now.  i hope this is the last fix for this problem...
> >
> > So did I, but alas...
> >
> > installed the new CVS version.
> >
> > this time I tried using alsaplayer -d jack.
> >
> > apart from not getting any sound, all seemed to work for a while. I
> > then Ctrl-C 'd jack and restarted it. Result: instant lockup.
> > I do have the impression that it takes longer for the lockup to occur.
> >
> > I'll try again with spiralsynthmodular, and I'll try to figure out if
> > the restarting of Jack has something to do with this.
> >
> > Pieter
>
> and so I tried spiralsynthmodular...
> it still hangs the system, but now it runs a little longer than
> yesterday (a minute instead of some seconds).
> and the restarting of jack doesn't affect it, i.e. this time it crashed
> on the first jack session.
>
> I'm sorry that I can't provide you with any more info... if you have
> some suggestions on gathering more usefull info, please let me know.
>
> Pieter

Just a longshot, and forgive me if it's already been raised : you aren't using 
ext3 by any chance? There are issues with kernel 2.4.20, ext3 which can cause 
lockups when being used to hard disk recording : this has been shown up while 
using Ardour. I don't know if it relates, but thought it might help.

t
-- 
GPG: http://n12turbo.com/tarragon/public.key


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
