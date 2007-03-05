From: "Maen Suleiman" <maen.suleiman@gmail.com>
Subject: Re: User data in ie958 frames
Date: Tue, 6 Mar 2007 00:08:51 +0200
Message-ID: <9c1cad6e0703051408i3a29234arcaf613e91960e6a4@mail.gmail.com>
References: <9c1cad6e0703031530n7436376bpcd062eba08eafa07@mail.gmail.com>
	<75b66ecd0703031647t2c17a5a1w45760180ee40e0ef@mail.gmail.com>
	<9c1cad6e0703032253v571a94d5q83ba82ceb76f2eed@mail.gmail.com>
	<75b66ecd0703042054ybff0a05o549b804c9d2537c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <75b66ecd0703042054ybff0a05o549b804c9d2537c8@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Thanks, Maybe because I am new to ALSA , I am not able to explain
exactly what I want.
The issue that I am trying to figure is in SPDIF (iec958) frame , How
can I update the 'user data bits' to ALSA from a Capture stream , and
read the the 'user bits' from ALSA  to update a Playback stream .
thats if I will use a SNDRV_PCM_FORMAT_U24_LE format for example . (
and not SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE ) . because my HW have
registers for channel status and user data .

I saw in many ALSA drivers that get and updates 'channel status' bits,
( e.g. snd_emu10k1_spdif_get and snd_emu10k1_spdif_put functions ) .
but didn't see any driver that updates or read user bits .

Thanks in advance



On 3/5/07, Lee Revell <rlrevell@joe-job.com> wrote:
> On 3/4/07, Maen Suleiman <maen.suleiman@gmail.com> wrote:
> > But as I saw, channel status is changed by drivers, in the controller
> > interface, why not the user data as well.
> >
>
> Can you explain exactly what problem you are trying to solve?
>
> Lee
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
