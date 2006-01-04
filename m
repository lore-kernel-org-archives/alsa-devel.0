From: Arnaud Patard <apatard@mandriva.com>
Subject: AD1986a
Date: Wed, 04 Jan 2006 19:22:21 +0100
Message-ID: <m34q4jx38i.fsf@anduin.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi,


I have the same problem as
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1678

I though that it was only a matter of how the hda verbs were initialised
so I made a patch allowing to change the channel configuration
(http://people.mandriva.com/~apatard/ad1986a_2channel_mode_fix.patch).
Unfortunately, this was not enough. 

Today, I've added this patch
http://people.mandriva.com/~apatard/dont_copy_front.patch which is
working but it's rather something ugly.

Moreover, I'm only able to test this with two speakers, so I don't know
if these patches are working with 4 or 6 channels setups.


Any hint on how to debug and fix this bug ?

Regards,
Arnaud



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
