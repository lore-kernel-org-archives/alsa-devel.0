From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: SPDIF output finally working properly with CS4630
Date: Tue, 23 Jul 2002 18:34:00 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020724013400.GA5214@porky>
References: <3D3DBDA2.10602@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D3DBDA2.10602@cucumelo.org>; from gorm@cucumelo.org on Tue, Jul 23, 2002 at 13:33:38 -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2002.07.23 13:33 Benny Sjostrand wrote:
> About other missing basic feutures, SPDIF input, 4 channels, multi PCM 
> etc., well, I'm working on that, we see what I can do, at least there is
> a hope ...
[...]
> Please, test it and give some feedback, maybe there are things that was 
> working before
> and are now broken., etc ...


    I've downloaded and installed your driver, but it seems that something
has changed in CVS since the rc2 release. Here's the error I'm getting:


[peter@porky als]$ aplay footsteps.wav Playing WAVE 'footsteps.wav' : 
Signed 16 bit Little Endian, Rate 44100 Hz, Mono
aplay: interval_inline.h:65: snd_interval_min: Assertion 
`!snd_interval_empty(i)' failed.
Aborted...


    I'm using the CVS of all the ALSA packages. I'm very interested
in S/PDIF output on my Santa Cruz, and will be watching your releases
with earnest.
    One request, however: would you release the files by themselves?
(versus the whole alsa-driver-0.9.0rc2 package)  I didn't have time
to check, but are you modifying anything beyond files in the
pci/cs46xx folder?

    I tested the driver with CVS and your package as a whole, with
the same response. Could it be something in alsa-lib that's changed?

Good luck!

-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
