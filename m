From: BMS <bob.sponge@gmail.com>
Subject: tying Master, Master Mono and Headphone controls together
Date: Fri, 29 Oct 2004 11:47:52 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <371a0364041029084729d4f439@mail.gmail.com>
Reply-To: BMS <bob.sponge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I'm sorry if this is a question that has been answered... I tried to
search the archives of the devel and user forums but came up empty
handed.

I'm trying to modify the ALSA driver (using 1.0.7rc2, but not married
to it) to tie the Master, Master Mono and Headphone volumes together.

The reason I need to do this is because the HP systems that we
purchased use Mono Out pins for their internal speakers, and Headphone
pins for both the Front and Rear output jacks.

I want any changes to the Master control of any mixer on the system to
result in all of those volume registers changing at the same time.

I've already added a new "quirk" to turn on the AD1981b's internal
"jack sense muting" to mute the mono_out when a plug is inserted in
the rear and/or front output jacks.  Tying these controls together is
the last step for me...

I appreciate any help!


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
