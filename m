From: Travis Place <wishie@wishie.net>
Subject: Re:
	=?iso-8859-1?q?PATCH_for_alsa-info=2Esh_-_using_mkte?=
	=?iso-8859-1?q?mp_for_instead_of=09hardcoded_temp_dir=2E?=
Date: Thu, 28 Feb 2008 02:55:30 +1000
Message-ID: <200802280255.30112.wishie@wishie.net>
References: <200802280036.52665.wishie@wishie.net>
	<s5hve4as6a3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-101-003.auto.usertools.net [202.137.101.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C80E103824
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 17:55:53 +0100 (CET)
Received: from [192.168.0.2] (unknown [192.168.0.200])
	by wishie.net (Postfix) with ESMTP id 13F095C784
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 17:17:18 +1000 (EST)
In-Reply-To: <s5hve4as6a3.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Feb 2008 2:39:16 am Takashi Iwai wrote:
> At Thu, 28 Feb 2008 00:36:52 +1000,
>
> Travis Place wrote:
> > Email subject should explain well enough.
>
> I see some problems with this change:
> - it doesn't work if /tmp/alsainfo doesn't exist
> - temp directory isn't removed if --no-upload is given
>
> I think you should avoid --tempdir=xxx with mktemp.
>
> The output file name is another question.
> IMO, it'd be better to pass the output file name via a command line
> option, and put it on the home directory (e.g. ~/alsa-info.out) as
> default rather than /tmp.
>
>
> Thanks,
>
> Takashi
>
> > --
> > Happiness is like peeing your pants. Everyone can see it, but only you
> > can feel its warmth
> > [2 alsa-info-mktemp.patch <text/x-diff; us-ascii (7bit)>]
> > diff -r e167861901c7 alsa-info.sh
> > --- a/alsa-info.sh	Tue Feb 26 10:55:47 2008 +0100
> > +++ b/alsa-info.sh	Thu Feb 28 00:29:37 2008 +1000
> > @@ -1,6 +1,6 @@
> >  #!/bin/bash
> >
> > -SCRIPT_VERSION=0.4.41
> > +SCRIPT_VERSION=0.4.42
> >  CHANGELOG="http://hg.alsa-project.org/alsa/log/tip/alsa-info.sh"
> >
> > 
> > #########################################################################
> >######## @@ -61,7 +61,7 @@ update() {
> >  }
> >
> >  cleanup() {
> > -	rm -r $TEMPDIR 2>/dev/null
> > +	rm -r $ALSAINFODIR 2>/dev/null
> >  }
> >
> >
> > @@ -99,7 +99,7 @@ withamixer() {
> >          echo "!!-------------" >> $FILE
> >          echo "" >> $FILE
> >  	for i in `grep "]: " /proc/asound/cards | awk -F ' ' '{ print $1} '` ;
> > do -	CARD_NAME=`grep "^ *$i " /tmp/alsainfo/alsacards.tmp|awk {'print
> > $2'}` +	CARD_NAME=`grep "^ *$i " $TEMPDIR/alsacards.tmp|awk {'print $2'}`
> > echo "!!-------Mixer controls for card $i $CARD_NAME]" >> $FILE echo ""
> > >>$FILE
> >  	amixer -c$i>> $FILE
> > @@ -122,9 +122,9 @@ withalsactl() {
> >          if [ -z "$exe" ]; then
> >          	exe=`whereis alsactl | cut -d ' ' -f 2`
> >          fi
> > -	$exe -f /tmp/alsainfo/alsactl.tmp store
> > +	$exe -f $TEMPDIR/alsactl.tmp store
> >  	echo "--startcollapse--" >> $FILE
> > -	cat /tmp/alsainfo/alsactl.tmp >> $FILE
> > +	cat $TEMPDIR/alsactl.tmp >> $FILE
> >  	echo "--endcollapse--" >> $FILE
> >  	echo "" >> $FILE
> >  	echo "" >> $FILE
> > @@ -255,8 +255,9 @@ fi # question
> >  fi # question
> >
> >  #Set the output file
> > -TEMPDIR="/tmp/alsainfo/"
> > -FILE="/tmp/alsa-info.txt"
> > +ALSAINFODIR="/tmp/alsainfo/"
> > +TEMPDIR=`mktemp -d --tmpdir=$ALSAINFODIR`
> > +FILE="$ALSAINFODIR/alsa-info.txt"
> >
> >  if [ "$PROCEED" = "yes" ]; then
> >
> > @@ -267,6 +268,7 @@ fi
> >  fi
> >
> >  #Create the temporary work dir.
> > +mkdir $ALSAINFODIR 2>/dev/null
> >  mkdir $TEMPDIR 2>/dev/null
> >
> >  #Fetch the info and store in temp files/variables
> > @@ -279,22 +281,22 @@ ALSA_DRIVER_VERSION=`cat /proc/asound/ve
> >  ALSA_DRIVER_VERSION=`cat /proc/asound/version |head -n1|awk {'print $7'}
> > |sed 's/\.$//'` ALSA_LIB_VERSION=`grep VERSION_STR
> > /usr/include/alsa/version.h 2>/dev/null|awk {'print $3'}|sed 's/"//g'`
> > ALSA_UTILS_VERSION=`amixer -v |awk {'print $3'}`
> > -VENDOR_ID=`lspci -vn |grep 040[1-3] | awk -F':' '{print $3}'|awk {'print
> > substr($0, 2);}' >/tmp/alsainfo/vendor_id.tmp` -DEVICE_ID=`lspci -vn
> > |grep 040[1-3] | awk -F':' '{print $4}'|awk {'print $1'}
> > >/tmp/alsainfo/device_id.tmp` +VENDOR_ID=`lspci -vn |grep 040[1-3] | awk
> > -F':' '{print $3}'|awk {'print substr($0, 2);}' >$TEMPDIR/vendor_id.tmp`
> > +DEVICE_ID=`lspci -vn |grep 040[1-3] | awk -F':' '{print $4}'|awk {'print
> > $1'} >$TEMPDIR/device_id.tmp` LAST_CARD=$((`grep "]: " /proc/asound/cards
> > | wc -l` - 1 ))
> > -cat /proc/asound/modules 2>/dev/null|awk {'print
> > $2'}>/tmp/alsainfo/alsamodules.tmp -cat /proc/asound/cards
> > >/tmp/alsainfo/alsacards.tmp
> > -lspci |grep -i "multi\|audio">/tmp/alsainfo/lspci.tmp
> > +cat /proc/asound/modules 2>/dev/null|awk {'print
> > $2'}>$TEMPDIR/alsamodules.tmp +cat /proc/asound/cards
> > >$TEMPDIR/alsacards.tmp
> > +lspci |grep -i "multi\|audio">$TEMPDIR/lspci.tmp
> >
> >  #Check for HDA-Intel cards codec#*
> > -cat /proc/asound/card*/codec\#* > /tmp/alsainfo/alsa-hda-intel.tmp 2>
> > /dev/null +cat /proc/asound/card*/codec\#* > $TEMPDIR/alsa-hda-intel.tmp
> > 2> /dev/null
> >
> >  #Check for AC97 cards codec
> > -cat /proc/asound/card*/codec97\#0/ac97\#0-0 >
> > /tmp/alsainfo/alsa-ac97.tmp 2> /dev/null -cat
> > /proc/asound/card*/codec97\#0/ac97\#0-0+regs >
> > /tmp/alsainfo/alsa-ac97-regs.tmp 2> /dev/null +cat
> > /proc/asound/card*/codec97\#0/ac97\#0-0 > $TEMPDIR/alsa-ac97.tmp 2>
> > /dev/null +cat /proc/asound/card*/codec97\#0/ac97\#0-0+regs >
> > $TEMPDIR/alsa-ac97-regs.tmp 2> /dev/null
> >
> >  #Fetch the info, and put it in $FILE in a nice readable format.
> > -echo
> > "name=$USER&type=33&description=/tmp/alsa-info.txt&expiry=&s=Submit+Post&
> >content=" > $FILE +echo
> > "name=$USER&type=33&description=$ALSAINFODIR/alsa-info.txt&expiry=&s=Subm
> >it+Post&content=" > $FILE echo "!!################################" >>
> > $FILE
> >  echo "!!ALSA Information Script v $SCRIPT_VERSION" >> $FILE
> >  echo "!!################################" >> $FILE
> > @@ -329,19 +331,19 @@ echo "!!Loaded ALSA modules" >> $FILE
> >  echo "!!Loaded ALSA modules" >> $FILE
> >  echo "!!-------------------" >> $FILE
> >  echo "" >> $FILE
> > -cat /tmp/alsainfo/alsamodules.tmp >> $FILE
> > +cat $TEMPDIR/alsamodules.tmp >> $FILE
> >  echo "" >> $FILE
> >  echo "" >> $FILE
> >  echo "!!Soundcards recognised by ALSA" >> $FILE
> >  echo "!!-----------------------------" >> $FILE
> >  echo "" >> $FILE
> > -cat /tmp/alsainfo/alsacards.tmp >> $FILE
> > +cat $TEMPDIR/alsacards.tmp >> $FILE
> >  echo "" >> $FILE
> >  echo "" >> $FILE
> >  echo "!!PCI Soundcards installed in the system" >> $FILE
> >  echo "!!--------------------------------------" >> $FILE
> >  echo "" >> $FILE
> > -cat /tmp/alsainfo/lspci.tmp >> $FILE
> > +cat $TEMPDIR/lspci.tmp >> $FILE
> >  echo "" >> $FILE
> >  echo "" >> $FILE
> >  echo "!!Advanced information - PCI Vendor/Device/Susbsystem ID's" >>
> > $FILE @@ -374,27 +376,27 @@ echo "" >> $FILE
> >  echo "" >> $FILE
> >  fi
> >
> > -if [ -s "/tmp/alsainfo/alsa-hda-intel.tmp" ]
> > +if [ -s "$TEMPDIR/alsa-hda-intel.tmp" ]
> >  then
> >  	echo "!!HDA-Intel Codec information" >> $FILE
> >  	echo "!!---------------------------" >> $FILE
> >  	echo "--startcollapse--" >> $FILE
> >  	echo "" >> $FILE
> > -	cat /tmp/alsainfo/alsa-hda-intel.tmp >> $FILE
> > +	cat $TEMPDIR/alsa-hda-intel.tmp >> $FILE
> >  	echo "--endcollapse--" >> $FILE
> >  	echo "" >> $FILE
> >  	echo "" >> $FILE
> >  fi
> >
> > -if [ -s "/tmp/alsainfo/alsa-ac97.tmp" ]
> > +if [ -s "$TEMPDIR/alsa-ac97.tmp" ]
> >  then
> >          echo "!!AC97 Codec information" >> $FILE
> >          echo "!!---------------------------" >> $FILE
> >          echo "--startcollapse--" >> $FILE
> >          echo "" >> $FILE
> > -        cat /tmp/alsainfo/alsa-ac97.tmp >> $FILE
> > +        cat $TEMPDIR/alsa-ac97.tmp >> $FILE
> >          echo "" >> $FILE
> > -        cat /tmp/alsainfo/alsa-ac97-regs.tmp >> $FILE
> > +        cat $TEMPDIR/alsa-ac97-regs.tmp >> $FILE
> >          echo "--endcollapse--" >> $FILE
> >  	echo "" >> $FILE
> >  	echo "" >> $FILE
> > @@ -549,7 +551,7 @@ if [[ -n "$DIALOG" ]]
> >  if [[ -n "$DIALOG" ]]
> >  then
> >  	if [[ -z $NOUPLOAD ]]; then
> > -	wget -O - --tries=5 --timeout=60 --post-file=/tmp/alsa-info.txt
> > "http://pastebin.ca/quiet-paste.php?api=$PASTEBINKEY&encrypt=t&encryptpw=
> >blahblah" &>/tmp/alsainfo/wget.tmp || echo "Upload failed; exit" +	wget -O
> > - --tries=5 --timeout=60 --post-file=$ALSAINFODIR/alsa-info.txt
> > "http://pastebin.ca/quiet-paste.php?api=$PASTEBINKEY&encrypt=t&encryptpw=
> >blahblah" &>$TEMPDIR/wget.tmp || echo "Upload failed; exit" { for i in 10
> > 20 30 40 50 60 70 80 90; do
> >  		echo $i
> >  		sleep 0.2
> > @@ -560,7 +562,7 @@ else
> >
> >  	if [[ -z $NOUPLOAD ]]; then
> >  	echo -n "Uploading information to www.pastebin.ca ... "
> > -	wget -O - --tries=5 --timeout=60 --post-file=/tmp/alsa-info.txt
> > http://pastebin.ca/quiet-paste.php?api=$PASTEBINKEY
> > &>/tmp/alsainfo/wget.tmp & +	wget -O - --tries=5 --timeout=60
> > --post-file=$ALSAINFODIR/alsa-info.txt
> > http://pastebin.ca/quiet-paste.php?api=$PASTEBINKEY &>$TEMPDIR/wget.tmp &
> > fi
> >  fi
> >  #Progess spinner for wget transfer.
> > @@ -579,9 +581,9 @@ if [[ -z $NOUPLOAD ]]; then
> >  if [[ -z $NOUPLOAD ]]; then
> >  	if [[ -n "$TPUT" ]]
> >  	then
> > -		FINAL_URL=`tput setaf 1; grep "SUCCESS:" /tmp/alsainfo/wget.tmp |sed
> > -n 's/.*\:\([0-9]\+\).*/http:\/\/pastebin.ca\/\1/p';tput sgr0`
> > +		FINAL_URL=`tput setaf 1; grep "SUCCESS:" $TEMPDIR/wget.tmp |sed -n
> > 's/.*\:\([0-9]\+\).*/http:\/\/pastebin.ca\/\1/p';tput sgr0` else
> > -		FINAL_URL=`grep "SUCCESS:" /tmp/alsainfo/wget.tmp |sed -n
> > 's/.*\:\([0-9]\+\).*/http:\/\/pastebin.ca\/\1/p'` +		FINAL_URL=`grep
> > "SUCCESS:" $TEMPDIR/wget.tmp |sed -n
> > 's/.*\:\([0-9]\+\).*/http:\/\/pastebin.ca\/\1/p'` fi
> >  fi
> >  #Output the URL of the uploaded file.
> > @@ -603,8 +605,8 @@ then
> >  		dialog --backtitle "$BGTITLE" --title "Information uploaded" --yesno
> > "Would you like to see the uploaded information?" 5 100
> > DIALOG_EXIT_CODE=$?
> >  	if [ $DIALOG_EXIT_CODE = 0 ]; then
> > -		grep -v "alsa-info.txt" /tmp/alsa-info.txt >/tmp/alsainfo/uploaded.txt
> > -		dialog --backtitle "$BGTITLE" --textbox /tmp/alsainfo/uploaded.txt 0 0
> > +		grep -v "alsa-info.txt" $ALSAINFODIR/alsa-info.txt
> > >$TEMPDIR/uploaded.txt +		dialog --backtitle "$BGTITLE" --textbox
> > $TEMPDIR/uploaded.txt 0 0 fi
> >  	fi
> >  fi
> > [3  <text/plain; us-ascii (7bit)>]
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
Ahh, crap, errors galore.. im too tired for this.. ill take a proper go at it 
later.. sorry


-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
