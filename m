From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: snd-rme9652 fails
Date: Mon, 22 Dec 2003 07:38:52 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312221238.hBMCcqlt015332@dhin.linuxaudiosystems.com>
References: <20031219103248.GB29650@master.mivlgu.local>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 19 Dec 2003 13:32:48 +0300."
             <20031219103248.GB29650@master.mivlgu.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

i'm a bit late to the party, but ...

>> > --- rme9652.c.ORIGINAL	Thu Dec 18 23:43:36 2003
>> > +++ rme9652.c	Thu Dec 18 23:45:12 2003
>> > @@ -1618,7 +1618,6 @@
>> >  RME9652_SPDIF_RATE("IEC958 Sample Rate", 0),
>> >  RME9652_ADAT_SYNC("ADAT1 Sync Check", 0, 0),
>> >  RME9652_ADAT_SYNC("ADAT2 Sync Check", 0, 1),
>> > -RME9652_ADAT_SYNC("ADAT3 Sync Check", 0, 2),
>> >  RME9652_TC_VALID("Timecode Valid", 0),
>> >  RME9652_PASSTHRU("Passthru", 0)
>> >  };
>> 
>> Yes, duplicated controls ARE NOT ALLOWED NOW. Applied. Thanks.

how did this code imply a duplicate control? removing it is
*wrong*, utterly wrong. it is an important control for some purposes.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
