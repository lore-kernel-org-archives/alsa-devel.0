From: Alex Austin <circuitsoft.alex@gmail.com>
Subject: Re: ALSA SDL VORBIS playback problem
Date: Tue, 2 Mar 2010 13:09:20 -0600
Message-ID: <53baa24a1003021109xe1c76dekc7f390a2a851df28@mail.gmail.com>
References: <7299058.27442.1267552227471.JavaMail.fmail@mwmweb068>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f189.google.com (mail-iw0-f189.google.com
	[209.85.223.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D7A61038A1
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 20:09:21 +0100 (CET)
Received: by iwn27 with SMTP id 27so472699iwn.5
	for <alsa-devel@alsa-project.org>; Tue, 02 Mar 2010 11:09:20 -0800 (PST)
In-Reply-To: <7299058.27442.1267552227471.JavaMail.fmail@mwmweb068>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Wolf <wolflpz@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Experiment. On the arm board:

$ oggdec myfile.ogg -o - | aplay -

Basically, see if a straight-up pipe will buffer reasonably. If not, I
suppose it's remotely possible that this is just a CPU-bound operation and
it can't keep up. I can't imagine that's really the case though with that
CPU.

On Tue, Mar 2, 2010 at 11:50 AM, Christian Wolf <wolflpz@web.de> wrote:

> I'm using SDL on an ARM based board running Linux (Olimex-AT91SAM9261) . I
> successfully cross-compiled, installed and tested the libraries (SDL,
> SDL_mixer) on the system. The sound output is done thru ALSA
> (SDL_AUDIODRIVER=3Dalsa). And the ogg file decoding thru
> libvorbis/libvorbisfile libraries.
>
> Now I'm trying to play ogg files. First I used the Mix_LoadWAV macro from
> the SDL_Mixer library for playback. This worked, but the macro decompress=
es
> first the complete audio file into memory and then starts the playback. T=
hus
> leading to a long delay before playing the music. Therefore I tried a
> different approach with the Mix_LoadMUS macro (SDL_mixer) to play the ogg
> file. This function streams the files directly from the hard-disk and avo=
ids
> the long decoding time. Unfortunately ALSA shows several buffer under-runs
> leading to a disrupted playback. To fix this I tried different buffer siz=
es,
> but the problem is still existent.
>
> The code works fine on my host system, but not on the ARM target. And i'm
> not sure if these problems are caused by the ALSA lib?
>
> Any sort of help would be great!
>
> Thanks in advance
> Christian
> ___________________________________________________________
> GRATIS f=FCr alle WEB.DE-Nutzer: Die maxdome Movie-FLAT!
> Jetzt freischalten unter http://movieflat.web.de
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
