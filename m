From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: 3D accelration control interface
Date: Thu, 20 Nov 2003 14:11:22 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1069348281.809.157.camel@localhost>
Reply-To: mjander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I asked this before, but since nothing seems to happen by itself, i
decided to start designing a control interface for ALSA to handle
hardware assisted 3D positional audio.

Goals of the design:

* Provide a standart naming scheme to access 3D capable audio streams.

* Provide a very thin comunication layer for access to hardware specific
registers.

* Provide a well defined control interface (kcontrol or ioctl) to higher
level libraries like OpenAL.

* Provide 2 entry points: One for capabilities and data query and
another for scene rendering (set parameters of 3D stream). This should
be implemented not as system calls, but rather as kcontrol or ioctl
calls.


Anyone wanting to contribute is gladly welcome to do so.

Best Regards

Manuel Jander





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
