From: Justin Cormack <justin@street-vision.com>
Subject: Re: HDSP + multiface "freezing" patch
Date: 07 Mar 2003 14:01:04 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1047045670.1414.19.camel@lotte>
References: <1046969583.1338.3.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1046969583.1338.3.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, paul@linuxaudiosystems.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-03-06 at 16:53, Thomas Charbonnel wrote:
> We were searching a vicious bug, but it was a trivial one...
> Applies on top of Paul's patch version II.
> 
> Thomas
>

ok, I am trying to test Paul's patch on the HDSP9652, but I cant get it
to play anything. I applied it to 0.9.0rc8b, but aplay just returns


laying WAVE '/home/justin/sound/track_3.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
ALSA lib pcm_params.c:2094:(snd_pcm_hw_refine_slave) Slave PCM not
usable
aplay: set_params:782: Broken configuration for this PCM: no
configurations available

The tail of strace is

pen("/home/justin/sound/track_3.wav", O_RDONLY) = 3
read(3, "RIFF4\276\250\1WAVEfmt \20\0\0\0\1\0\2\0", 24) = 24
read(3, "D\254", 2)                     = 2
read(3, "\0\0\20\261\2\0\4\0\20\0", 10) = 10
read(3, "data\20\276\250\1", 8)         = 8
write(2, "Playing WAVE \'/home/justin/sound"..., 48Playing WAVE
'/home/justin/sound/track_3.wav' : ) = 48
write(2, "Signed 16 bit Little Endian, ", 29Signed 16 bit Little Endian,
) = 29
write(2, "Rate 44100 Hz, ", 15Rate 44100 Hz, )         = 15
write(2, "Stereo", 6Stereo)                   = 6
write(2, "\n", 1
)                       = 1
ioctl(4, 0xc25c4110, 0xbffff260)        = -1 EINVAL (Invalid argument)
write(2, "ALSA lib pcm_params.c:2094:(snd_"..., 53ALSA lib
pcm_params.c:2094:(snd_pcm_hw_refine_slave) ) = 53
write(2, "Slave PCM not usable", 20Slave PCM not usable)    = 20
write(2, "\n", 1
)                       = 1
write(2, "aplay: set_params:782: ", 23aplay: set_params:782: ) = 23
write(2, "Broken configuration for this PC"..., 62Broken configuration
for this
PCM: no configurations available) = 62
write(2, "\n", 1
)                       = 1
_exit(1)                                = ?




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
