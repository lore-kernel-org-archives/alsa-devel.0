From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: C-Media 8378 revision 37 & OPL3 midi
Date: Fri, 19 Jul 2002 19:00:48 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D37E350.1080806@boosthardware.com>
References: <200207190917.g6J9H86o079380@smtpzilla5.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Sander van Leeuwen <sandervl@xs4all.nl>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Sander van Leeuwen wrote:
> Hi,
> 
> I have two cmedia cards; a revision 37 & 39. Everything
> works well on the rev 39 card, but OPL3 midi is silent
> on the rev37.
> OPL3 initialization succeeds and there are no clear signs
> of any problems. My first guess was that this revision
> may have a difference (bug) with regards to the FM
> volume. However, testing different mute & volume settings 
> shows no improvement.
> All the IO registers related to FM appear to be working as
> specified in the CMedia docs.
> 
> Is this a know problem of the ALSA driver, a hardware bug or 
> even a defective OPL3 part in this particular revision?
> 

Can you let us know what you have done to get the midi i/o working? 
Preferably with debugging output. MIDI in ALSA is still a bit of a 
blackart so you may not have correctly setup everything yet.

Also have a look at the LAU guide (see below) and the quicktoots for 
more info on playing MIDI through ALSA.


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
