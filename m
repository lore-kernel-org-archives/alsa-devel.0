From: Fred Gleason <fredg@salemradiolabs.com>
Subject: Re: AudioScience driver
Date: Tue, 24 Jun 2003 23:23:15 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306242323.15168.fredg@salemradiolabs.com>
References: <20030623221451.6728.h005.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030623221451.6728.h005.c012.wm@mail.icqmail.com.criticalpath.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eliot Blennerhassett <bigblen@icqmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 24 June 2003 01:14, Eliot Blennerhassett wrote:

> I have attached a patch against alsa-driver-0.9.4
> But I'm not sure if this is the desired form, or whether I have located the
> driver in the correct part of the tree.

I've tried building things with the patch, and have some questions:

1)  Your directions tell me to execute a './cvsconfigure' command (at the root 
of the ALSA source tree).  There is no such command in the 0.9.4 tree (at 
least in the tarball).  Does this patch require use of a checked-out CVS 
tree?

2)  What is the name of the module that this should generate?  'snd-asihpi' is 
coming up as not found.

3)  What is the exact relationship between the ALSA module and 'asihpi'?  Does 
one need to be loaded for the other to work?  Exactly what is dependent upon 
what?  An example 'modules.conf' setup would be very helpful here!


> This driver depends on a module external to ALSA (asihpi, (GPL), available
> from our website).  I couldn't figure out how to add a driver specific
> include path, so  I made a symbolic link across to the (only one) header
> file.

I'd like to propose that the "standard" location of the HPI header henceforth 
be:

	/usr/include/hpi/hpi.h

Then, applications need only do:

#include <hpi/hpi.h>

for things to work.  I've been using this layout in my own apps for some time 
now.  While we're at it, perhaps we could add an install rule for this into 
the makefile for hpklinux (and one for libhpi.a >> /usr/lib as well).  This 
would have the added benefit of getting strange symlinks out of the ALSA 
source tree.  :)

Cheers!


|-------------------------------------------------------------------------|
|      Frederick F. Gleason, Jr.      |         Salem Radio Labs          |
|       Voice: 1-(540)-341-2880       |      87 Lee Highway, Suite 11     |
|        FAX: 1-(540)-341-7176        |        Warrenton, VA 20188        |
|-------------------------------------------------------------------------|
|   Some people call them "cars" or "trucks"; I call them "dimensional    |
|   transmogrifiers" because they change three-dimensional cats into      |
|   two-dimensional ones.                                                 |
|                                         -- F. Frederick Skitty          |
|-------------------------------------------------------------------------|



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
