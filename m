From: cliffw@easystreet.com
Subject: Re: usb-audio - kernel oops 2.5.72
Date: Tue, 24 Jun 2003 20:41:40 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306250341.h5P3fepX005345@oldred.easystreet.com>
References: <tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Message from Takashi Iwai <tiwai@suse.de>
   of "Tue, 24 Jun 2003 11:54:51 +0200." <s5hk7bbx0k4.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: cliffw@easystreet.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> At Mon, 23 Jun 2003 23:54:46 -0700,
> cliffw@easystreet.com wrote:
> > 
> > > At Sun, 22 Jun 2003 20:45:09 -0700,
> > > cliffw@easystreet.com wrote:
> > > > 
> > > > 
> > > > Am attempting to get linux-2.5.72 + snd-usb-audio happening.
> > > > Results have been poor. Machine is VIA C3, ALSA + jack working 
> > > > fine with the built-in via audio. Tried various kernels, 
> > > > real ugly failures with 2.5.70, also have tried 2.5.72-mm2. 
> > > 
> > > i fixed a bug in usb-audio driver on the cvs now.
> > > there are some calls of functions which may call schedule() in the
> > > spinlock.
> > > 
> > > please try the cvs version.
> > Am attempting, so far compile errors in serialmidi....am
> > getting the whole tree now. 
> 
> you don't need alsa-driver tree to compile the ALSA on 2.5.x (unless
> you use the drivers in it).  the codes in alsa-kernel tree are ready
> for 2.5 kernel.  that is, copy the files and directories to 2.5 tree
> and build the modules there.
> 
> it would be nice to have a simple sync script for that...

Well, if you want simple, i can do that :)
This appears to be working for me....(i wait for the compile, again)

---------------------------------
alsa.cvs.copy
-----------------------------
#!/bin/sh
# A very simple script to copy alsa-kernel cvs where i want it

if [ ! $1 ]; then
        echo "Need arg for destination directory"
        exit 1
        fi

if [ -e $1 ]; then
        DEST=$1
else
        echo "Destination $1 doesn't appear to exist"
        exit 1
fi

HERE=`pwd`
BASE=`basename $HERE`
echo $HERE $BASE
if [ $BASE != "alsa-kernel" ]; then
        echo "Must execute me inside alsa-kernel!"
        exit 1
        fi

echo "Copying alsa-kernel cvs to $DEST"

# I could be really cute here and copy globs, but
# That Would Not Be Safe
# So, we'll be slow, simple and careful
# CHANGE these lists if needed

SOUNDDIRS="drivers isa parisc ppc usb arm i2c pci scripts sparc core oss 
pcmcia synth"
SOUNDFILES="last.c  sound_core.c  sound_firmware.c Makefile Kconfig"

#Copy the Documentation to the Documentation

cp -r Documentation/* ${DEST}/Documentation/

# Copy the include files to include/sound

cp -r include/* ${DEST}/include/sound

for i in $SOUNDDIRS
do
        cp -r ${i}/* ${DEST}/sound/${i}/
done
for i in $SOUNDFILES
do
        cp ${i} ${DEST}/sound/${i}
done

exit 0
-------------------------
end

cliffw

> 
> 
> Takashi
> 




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
