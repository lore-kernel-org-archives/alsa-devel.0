From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Wed, 18 Sep 2002 11:58:12 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209181858.LAA07860@cmn29.stanford.edu>
References: <Pine.LNX.4.33.0209181416130.534-100000@pnote.perex-int.cz>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209181416130.534-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Chris Rankin <rankincj@yahoo.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > > Note: If
> > > SND_COMPATIBILITY_BUILD_RC3 is defined,
> > > then applications need to fall back to 0.9.0rc3 API
> > > as well.
> >
> > So maybe we could have a --with-compat-rc3 option for
> > alsa-utils as well? Regardless of which alsa-lib I
> > build, I always need to be able to build alsa-utils.
> > And I doubt that wine and xine will get updated before
> > -rc4 is released. (Unless there's a document somewhere
> > explaining the relationship between the old and new
> > API functions, in which case I could submit patches
> > myself.)
>
> It seems, that you're not understand the compatibility.
>
> 1) build library with --with-compat-rc3 and place it to some
> other directory

No, no and no. No need to if the versions of the library are
different. And they better be different!! They should go into
prefix/lib (normally /usr/lib) so that older applications keep
working until they are recompiled with the new version of the
api.

> 3) build library without --with-compat-rc3, place it to
> /usr/lib as usuall
> 4) build alsa-utils and newer applications
> 5) build older applications with compatible library compiled
> with --with-compat-rc3

Let me see if I understand, after all the compiling and
installing is done we have two shared libraries with different
versions in /usr/lib, and one set of header files in
/usr/include, and the behavior of the header files depends on
SND_COMPATIBILITY_BUILD_RC3 being defined (if it is defined
then the old prototype/api is used, if not then the new
prototype/api is used). So:

- old applications that use the old .so number keep working
- new applications that understand the new api can be
  compiled and linked as usual and they work with the new .so
  library.
- old applications that have to be recompiled can be
  recompiled with the old api if they define
  SND_COMPATIBILITY_BUILD_RC3

  [but how do they pick the older .so library over the new
  one at link time?, remember, they are in the same place, does
  this need any extra tricks or it just "happens"?]

Ok, so this is better than nothing, but I still have to say:

This is supposed to be 0.9.0rc3 going on 0.9.0rc4.
This is not 0.6 cvs.

NO API CHANGES PLEASE!!!!!!!!!!
Only bug fixes, new drivers maybe. RC releases are release
candidates, they are supposed to be stabilizing the thing! (in
my understanding)

Furthermore, I found about the api change by _chance_, because
I was testing the latest cvs versions (which have better usb
midi support) and for some reason tried to recompile jack and
it would not compile! I could not believe my eyes.

IF 0.9.0rc3 really means "release candidate 3" then this
change is not acceptable. Nothing is "broken" in the api,
nothing (AFAIK) _needs_ to be fixed or else applications will
not work. This is not new functionality. This is a style
change, to make things prettier and more consistent (which of
course I like). For any api change at any time, at the very
least developers have to be WARNED about the changes. In an
rc3 it should be mandatory (I mean, if you insist on changing
the api when it should be stable). Otherwise lets rename the
version to 0.8 or whatever.

I have to echo the previous comment on this thread: if we
still have an rc3 tarball in the web site that does not
compile out of the box then there is something wrong. Do we
want alsa adopted? Do we think that will happen if people
download it and cannot even compile it?? (no, the warning in
the site is NOT enough - witness the number of emails sent to
the list about this).

Sorry for the rant.

I understand that the sooner an api change is made the better,
but, again, this is rc3 and things are supposed to be stable
NOW.

As was mentioned before, create a NEW set of api calls, mark
the old ones as deprecated and erase them after two or three
releases. And document the improved api in a very distinctive
way, otherwise developers will not even notice the change.

-- Fernando


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
