From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Re: [PATCH] Interwave PCM name
Date: Sun, 12 May 2002 02:40:18 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020512024018.A16784@sci.fi>
References: <20020511005108.A16303@sci.fi> <Pine.LNX.4.33.0205110837200.509-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0205110837200.509-100000@pnote.perex-int.cz>; from perex@suse.cz on Sat, May 11, 2002 at 08:37:56AM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, May 11, 2002 at 08:37:56AM +0200, Jaroslav Kysela wrote:
> The revision is revision of interwave chip not codec which is only a part 
> of interwave chip. So this change does not make sense.

I don't understand what you mean. This is the name of a PCM device we're
talking about here.

This is without the patch:
# cat /proc/asound/pcm
00-00: CS4231 : AMD InterWave rev B (chip) : playback 1 : capture 1
00-01: AMD InterWave : AMD InterWave rev B (synth) : playback 1

Doesn't look right to me. It's always bee "(codec)" in the past.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
