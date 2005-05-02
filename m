From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Audigy 2 NX
Date: Mon, 2 May 2005 09:17:19 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505020858030.21377-100000@studcom.urz.uni-halle.de>
References: <ad2655cb0504290959498bda21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <ad2655cb0504290959498bda21@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> I notice that you are doing quite a bit of work on the Audigy 2 NX
> device. Do you have any ideas as to how we can set IEC958 non-audio
> bits on the optical out, and also detect IEC958 non-audio bits on the
> optical in. Also, do you have any ideas on how to set the SPDIF rate?

I think these things are done by doing some device-specific memory
reads/writes.  I haven't yet looked at a USB log of the Windows
driver.

Is it possible to set the SPDIF rate in Windows?


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
