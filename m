From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH]Audigy 2 ZS - side support
Date: Wed, 14 Jul 2004 01:48:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1089784121.7103.21.camel@mindpipe>
References: <200406280711.i5S7BGAQ017719@www4.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200406280711.i5S7BGAQ017719@www4.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-06-28 at 03:11, Peter Zubaj wrote:
> Hi,
> 
> Here are patches to add support for Audigy 2 ZS side speakers.
> They are against CVS from 23.06.2004. I hope they will apply cleanly.
> 
> audigy2zs_driver_v2.diff - is kernel part - same as in bugtrack but
> for CVS.
> 
> audigy2zs_lib_v2.diff - is alsa-lib part - this is not tested (it is
> same as from my mail and with changes from bugtrack from elklein)
> 
> TODO - detection of audigy 2 zs. Now it will add side controls to
> mixer for audigy 2 to. Maybe left or right slider can control volume
> of back center on audigy 2 too.
> 

The Audigy 2 ZS can be identified by (emu->revision ==4 &&
emu->model=0x2002).

Lee



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
