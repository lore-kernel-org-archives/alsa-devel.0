From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: How to put 16bit none audio PCM data stream into a 32bit none audio S/P-DIF transport stream?
Date: Tue, 8 Apr 2003 22:55:15 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030408205515.GB6940@ulima.unil.ch>
References: <20030408140230.GA1987@ulima.unil.ch> <E192u0x-0007pF-00@sc8-sf-list1.sourceforge.net> <s5hn0j1q97r.wl@alsa2.suse.de> <3E934193.6090605@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E934193.6090605@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: Takashi Iwai <tiwai@suse.de>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net, werner@suse.de
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 08, 2003 at 11:39:31PM +0200, Benny Sjostrand wrote:

> Exaclty what do you mean with 32bit spdif ? Sorry, I feel a little bit=20
> newbie about
> the SPDIF protocol specific details.

Well,

I have just copied an expert, Dr. Werner Fink, as he spoke in the
vdr@linuxtv.org mailing list about a problem with AC3overDVB:

"As long as the hardware on the DVB cards are not able to put
the 16bit none audio PCM data stream into a 32bit none audio
S/P-DIF transport stream all receivers which uses the bit flags
of the S/P-DIF transport stream for identifying none audio
loose.  All S/P-DIF data get from the DVB card to not have the
none audio bit set.  AFAIK this is a hardware bug (or better
this is the information I've got from TT) ..."

So I guessed if we are some for which the CS46xx driver don't work with
our receivers with the same sympton (here from the readme of AC3overDVB:
"If your receiver doesn't detect the encapsulated stream (at the
beginning of replay in general) you will hear the digital data played as
PCM data. It's a spiky noise. Don't turn up the volume too much, or the
speakers may be damaged. You have been warned!").


> From the cs46xx driver point of view, 48khz 16bit audio or AC3=20
> (non-audio) is the
> same thing, 16bit left, 16bit right.
> I think the cs46xx HW supports 20 bits resolution, but that's not=20
> implemented
> in the DSP firmware, therefor not supported by the driver (only 16bit=20
> stereo).

Well, I can't speake from the driver point of view, but with the
hardware it is working, at least under windows...
Maybe Dr. Werner Fink could clarify the situation?

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
