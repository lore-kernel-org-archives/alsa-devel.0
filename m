From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: SPDIF output finally working properly with CS4630
Date: Wed, 24 Jul 2002 13:12:01 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020724201201.GI1681@porky>
References: <3D3DBDA2.10602@cucumelo.org> <20020724013400.GA5214@porky> <3D3E2D08.3070800@cucumelo.org> <20020724181919.GC1681@porky> <3D3EF4CA.1090504@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D3EF4CA.1090504@cucumelo.org>; from gorm@cucumelo.org on Wed, Jul 24, 2002 at 11:41:14 -0700
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

On 2002.07.24 11:41 Benny Sjostrand wrote:
> About the IEC958, remember to unmute it via the ALSA mixer, it does not 
> apear
> with the Gnome Mixer, or any other OSS mixer.
> 
> When you are playing the .WAV file take a look in 
> /proc/asound/card0/dsp_scb
> and check after the line "0bc0 SPDIFOSCB:", should be something like:


    It's different than your included output, but it's not zero's. And yes,
I unmuted both entries "IEC958" and "IEC 958" with alsamixer.


-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
