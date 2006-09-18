From: Arnaud Patard <apatard@mandriva.com>
Subject: Re: snd-hda-intel - 5.1 speakers problem
Date: Mon, 18 Sep 2006 22:51:27 +0200
Message-ID: <m3k640hp9s.fsf@anduin.mandriva.com>
References: <55f590609181306h575c9a99wd308f0c554d5a3a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <55f590609181306h575c9a99wd308f0c554d5a3a3@mail.gmail.com>
	(Vishwanath T. K.'s message of "Tue, 19 Sep 2006 01:36:04 +0530")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Vishwanath T. K." <vishytk@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

"Vishwanath T. K." <vishytk@gmail.com> writes:


>> Hi All,

Hi

>
> I have had this problem for quite a while and could not get any solution so
> far. I have tried all possible options mentioned in the
> ALSA-configuration.txt and various suggestions from the mailing list but
> without any luck, hence finally decided to post the problem here.
>
> Problem:
> I am unable to get all (5.1) the speakers working. I get the sound only in
> four speakers connected to Line Out and Microphone jacks. Speakers connected
> to Line In jack outputs noise instead of the intended sound. This noise
> dissapears the moment the pin from this jack is removed.

I may be wrong but it may be a wrong configuration of the outputs. I
made a patch some time ago for that but I've never been able to test it
on other configuration than 2 channels output. In fact, I only
remembered of this patch when reading your mail :(

I'm not sure it's still applying on current version of the
patch_analog.c file but you may be interested in looking at it:

http://people.mandriva.com/~apatard/ad1986a_2channel_mode_fix.patch

If you can also test it in 4 channel mode, this would be nice. In the
case of all is working, one could ask to merge the patch :)

Regards,
Arnaud


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
