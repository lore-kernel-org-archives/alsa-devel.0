From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [lack of] dynamic detection/loading of modules
Date: Wed, 26 Feb 2003 22:33:33 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18oElA-0005cD-00@sc8-sf-list1.sourceforge.net>
References: <001d01c2de0f$8715e530$aa1f830a@ICO>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 26 Feb 2003 22:22:48 EST."
             <001d01c2de0f$8715e530$aa1f830a@ICO>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>lists about this and to do it cleanly it would be nice to have available
>in /proc/asound the list of modules currently loaded. That is not
>available today (I think Takashi said he might add that)."

cat /proc/modules | grep '^snd'



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
