From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: pcm_jack plugin attempt
Date: Wed, 5 Feb 2003 18:24:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030205182453.58f0c24b.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I am trying to write a pcm_jack plugin, which would allow existing alsa
applications to use jack as input/output, without changing any code. The
plugin will use some internal circular buffer for the data transfer
between the alsa read/write calls and the async jack process callback.

I have been studying the code of the various plugins, had some private
communication on the subject with Paul Davis and Abramo, and written
some code, but I am rather stuck... Your help would be greatly
appreciated.

As far as I understand, the easiest solution would be to have a pcm_plug
plugin inbetween the alsa application and the pcm_jack plugin, to take
care of sample rate and data format conversion. Then the pcm_jack plugin
simply restrict it configuration space to the sample rate and data format
(float) supplied by the jack server. Is this the right approach? Then,
what would be the right place to do this? In the hw_refine or in the
hw_param function? Or somewhere else even? And how - what _snd_pcm helper
functions should I best use?

Jack will allow to open as many ports as necesary, so I will open one
port for each channel. Is the prepare function the correct place to do
so?

Most pcm plugins use a slave, but as the pcm_jack plugin will be an
end-point, it will not have any slave. Do I see this correctly? 

Thanks in advance for any reply!

Maarten


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
