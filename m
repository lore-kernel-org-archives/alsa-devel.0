From: "Ronald S. Bultje" <R.S.Bultje@students.uu.nl>
Subject: speaker configuration
Date: Thu, 22 Jul 2004 20:55:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1090522504.29769.29.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

if I setup a sound playback stream using N channels, how do I find out
what the speaker configuration is? For example, my SB Audigy 2 NX
supports (using hw: access) 2, 4, 6 and 8 channels. 2 is stereo, 8 is
probably 7.1 (3 front, 2 side, 2 rear, 1 lfe), 6 is probably 5.1 (same
as 7.1, without side). What is 4? If I open the card using plughw:, I
get 1-32 channels. What does each of those mean? And related to this,
what is the speaker's position order? In other words, if I send 8
interleaved channelsamples of sound (1 soundsample) to my channels=8
soundcard, on what speaker will the first, second, ... channelsample be
played?

Thanks,

Ronald


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
