From: "mjander " <mjander@embedded.cl>
Subject: New driver
Date: Tue,  4 Mar 2003 19:35:35 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303041935.AA192217402@embedded.cl>
Reply-To: <mjander@embedded.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi,

I started writing a new driver for the Aureal Vortex soundcards.
Now the howto is pretty  good, and the  basic stuff is nearly
complete, but
how do i integrate  my driver into the configure scripts,
Makefiles, and
all sorts of  thingiees that  makee up the tree ?
I placed the driver (several files) into  the directory
"pci/vortex". I  managed to get the configure script to recognice
the "vortex" card fiddling in the  acinclude.m4  file,  but  when
i  do "make" it doesnt compile  the  files in "/pci/vortex". This
directory has a  apropiate makefile  (i  took the one  of the
emu10k1 an d modiifyed it).

What is the "official" procedure to integrate  my driver ?

Thanks.

Manuel Jander
.
__________________________________________________
Enviado via NewPlanet WebMail en embedded.cl


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
