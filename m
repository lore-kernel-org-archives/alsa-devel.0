From: Juan Linietsky <coding@reduz.com.ar>
Subject: Re: rawmidi problem (was Re: ALSA homepage redesign)
Date: Mon, 22 Apr 2002 14:12:57 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020422141257.070b25a9.coding@reduz.com.ar>
References: <Pine.LNX.4.33.0204221307200.564-100000@pnote.perex-int.cz>
	<0GUZ004K22BUKO@l-daemon>
	<s5hsn5n3ee8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsn5n3ee8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 22 Apr 2002 18:07:59 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> however i don't understand quite well the situation from your posts.
> could you elaborate the symptom?
> which program and how did you test?
> 
> 
> Takashi

Hello!

Actually, if you dont mind i have some questions to ask you.
First, about the awe64 on ALSA, what happened with the individual
chorus/reverb settings per channel in the synth? I dont seem to be
able to get them to work aymore except for a global buffer.
About this too, is there a way to change the reverb/chorus types
that i know the awe64 supports?

About the sblive sequencer on ALSA, from what i can deduce, it seems to be a bug in the code that tries to allocate a free channel.. is there any work around for this? Also about the insert effects on the sblive,
I havent found the way to map them into midi controllers (my guess is that the sblive uses a global send buffer for effects and send levels per channel so they cant be mixed that easily?)

Thanks for your time!

Juan Linietsky
