From: Pieter Palmers <ppalmers@esat.kuleuven.ac.be>
Subject: userspace pcm/midi for firewire based cards
Date: Mon, 15 Nov 2004 18:58:28 +0000
Message-ID: <4198FC54.7000309@esat.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm working on the development of DM1000 based firewire based devices 
(ESI QuataFire 610, M-Audio FireWire devices, ...).
The question that arises is: userspace driver or kernel driver. 
Personally I favor the userspace driver, because we can use the FW libs 
that are already present for some of the stuff. On the other hand it 
seems to me that programming a kernel driver would be ?easier? than 
implementing a plugin. If I'm right, that would require providing all 
interfaces/capabilities the alsa-lib middle layer provides.
What are the thoughts about this on this list? I've already seen some 
small discussions about this (e.g. bluetooth), but I'm not completely 
convinced... what about the latency/realtime behaviour of the two options?

 From a development perspective I do think that it's nice to work in 
userland. I still remember the numerous reboots when working on the isis 
kernel driver...
Would it be interesting to construct userland code in such a way that it 
is easy to migrate it to kernel space? Or isn't it worth the effort?

And finally a practical question: The PCM part can be implemented as a 
plugin, for which I should look at pcm_jack.c. Is there an equivalent 
plugin mechanism for MIDI stuff? I've googled around, but I couldn't 
find a clear answer.

Greets,

Pieter Palmers
FreeBoB project
freebob.sourceforge.net


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
