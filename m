From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Single process freeze when opening capture device
Date: Thu, 29 May 2003 10:56:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ED5CB39.6000502@libero.it>
References: <Pine.LNX.4.44.0305290907470.28435-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0305290907470.28435-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Arthur Peters <amp@singingwizard.org>, Alsa dev List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela ha scritto:
> On Wed, 28 May 2003, Arthur Peters wrote:
> 
> 
>>I have found what seems to be a bug in ALSA (CVS of this afternoon).
>>When a program opens certain PCM devices for capture the program blocks
>>forever in snd_pcm_open (both the library function and the kernel
>>function actually). The PCM device I have been testing it with is
>>surround40 on a emu10k1 (SBLive Value). I am trying to capture on this
>>device because I want to have jack use surround40 (actually a route
>>plugin device pointing to it) so that I can use all 4 outs and both ins
>>at the same time.
>>
>>Below is a minimal setup that reproduces the problem for me.
>>
>>alsa_freeze.c
>>------------------
>>#include <alsa/asoundlib.h>
>> 
>>int main( int argc, char* argv[] )
>>{
>>        snd_pcm_t *pcm;
>>        snd_pcm_open(&pcm, "surround40", SND_PCM_STREAM_CAPTURE, 0);
>>        return 0;
>>}
> 
> 
> It is limit of current alsa-lib configuration. We cannot distinct playback
> and capture. But I am not sure, if returning an error helps you
> (surround40 configuration is NOT valid for emu10k1). I suggest to fix jack
> to allow different names for playback and capture with different count of
> channels.
> 

What about a "dir" field in common section of pcm configuration?

   dir STR	# PCM allowed directions "playback", "capture", "both" (default)

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
