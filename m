From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: [ANN] ALSA-native sfxload program
Date: Wed, 28 Jan 2004 14:35:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2hdygnqm1.fsf@vador.mandrakesoft.com>
References: <s5h8yjt1nlu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yjt1nlu.wl@alsa2.suse.de> (Takashi Iwai's message of "Tue,
 27 Jan 2004 15:18:37 +0100")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> I added a new interface to ALSA 1.0.2 for handling the SoundFont file
> without OSS sequencer emulation.  The latest awesfx package,
> ver.0.5.0, includes a new program "asfxload" for that.  As you imagine
> easily, it's the ALSA-native sfxload program.
> 
> It works just like sfxload but loads via ALSA-native hwdep device.
> No new features, no new bugs :)
> 
> Also, awesfx is now packaged with GNU auto-tools.  You can use
> configure script like others.
> 
> The web page is at
> 
> 	http://www.alsa-project.org/~iwai/awedrv.html#Utils
> 
> The tarball is at
> 
> 	http://www.alsa-project.org/~iwai/awesfx-0.5.5.tar.gz

tv@ke ~/rpm $ lftpget http://www.alsa-project.org/~iwai/awesfx-0.5.5.tar.gz  
get: Access failed: 404 Not Found (~iwai/awesfx-0.5.5.tar.gz) 

correct url seems to be:
     http://www.alsa-project.org/~iwai/awesfx-0.5.0.tar.gz



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
