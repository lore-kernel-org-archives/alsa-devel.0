From: Javier Conti <av@labcc.ch>
Subject: Re: Fix for dell inspiron 8100 maestro3
Date: Sat, 17 May 2003 03:58:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305170358.33252.av@labcc.ch>
References: <200305161632.46562.av@labcc.ch> <s5hhe7vdjgc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhe7vdjgc.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 16 May 2003 17:01, Takashi Iwai wrote:
> are you sure that the patch is correct?
> your patch adds the same vendor an device id with the existing
> inspiron 8000 (1028:00a4).

I'm not sure. As stated in my previous posting, I'm not a developer. The only 
thing I'm sure of, is that without that patch, I can't use irda and the 
soundcard together, with this patch, I can.

I suppose the FIXME tag is there because nobody in the alsa team has a dell 
inspiron 8100 to test the driver on. If this is the case, and if my patch is 
not correct (which is more than possible) I'd be happy to cooperate to test 
other solutions (maybe someone could tell me how to spot the right device 
id?).

Having to reboot with a soundless kernel just to update my calendar and 
addressbook is very frustrating...

Thanks, Javier
-- 
Javier Conti - Labcc
Tel: +41(0)91 690 0703
Fax: +41(0)91 690 0702



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
