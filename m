From: Paul Davis <pbd@op.net>
Subject: Re: ALSA docs
Date: Mon, 29 Jul 2002 08:08:11 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17Z9If-0003MS-00@usw-sf-list1.sourceforge.net>
References: <3D44C6DE.6030704@boosthardware.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 29 Jul 2002 13:38:54 +0900."
             <3D44C6DE.6030704@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> i would personally work from a complete set of snd-* modules, and use
>> modinfo(1) + perl to get the information
>
>Isn't that what happens in the INSTALL file anyway?

it doesn't look like it. there are several cards missing there, and it
looks hand-written rather then fetched from the source.

>> and put that into the temp
>> file that is inserted into the template, or if possible, put it
>> straight into the template.
>> 
>
>IIRC doing the above would need access to a set of modules online. Seems 
>unneccesary when the INSTALL file is already available.
>
>But I'm willing to be told otherwise if it makes the info more reliable.

it would be much more reliable if you got the options from the modules
themselves. even just running grep for MOD_PARM etc. would be better
than using the INSTALL file.

--p


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
