From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp I/O-error
Date: 12 Apr 2003 21:45:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1050176702.1427.681.camel@satellite.undata.org>
References: <200304112048.38744.Jaakko.Prattala@Helsinki.FI>
	 <1050086275.1337.37.camel@satellite.undata.org>
	 <200304121240.17736.Jaakko.Prattala@Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304121240.17736.Jaakko.Prattala@Helsinki.FI>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaakko =?ISO-8859-1?Q?Pr=E4tt=E4l=E4?= <Jaakko.Prattala@Helsinki.FI>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


> Hi. More info. This is the /var/log/messages output when I run hdsploader.
> 
> Apr 12 12:30:56 kiertotahti kernel: ALSA 
> ../../alsa-kernel/pci/rme9652/hdsp.c:4104: card initialization pending : 
> waiting for firmware
> Apr 12 12:31:03 kiertotahti kernel: ALSA 
> ../../alsa-kernel/pci/rme9652/hdsp.c:644: wait for FIFO status <= 0 failed 
> after 30 iterations
> Apr 12 12:31:03 kiertotahti kernel: ALSA 
> ../../alsa-kernel/pci/rme9652/hdsp.c:3800: initializing firmware upload
> Apr 12 12:31:03 kiertotahti kernel: ALSA 
> ../../alsa-kernel/pci/rme9652/hdsp.c:522: loading firmware
> Apr 12 12:31:03 kiertotahti kernel: ALSA 
> ../../alsa-kernel/pci/rme9652/hdsp.c:548: finished firmware loading
> Apr 12 12:31:07 kiertotahti kernel: ALSA 
> ../../alsa-kernel/pci/rme9652/hdsp.c:644: wait for FIFO status <= 127 failed 
> after 5000 iterations
> Apr 12 12:31:07 kiertotahti kernel: ALSA 
> ../../alsa-kernel/pci/rme9652/hdsp.c:3824: error creating alsa devices
> 
> (I/O-box shows host error).

Did the hardware show the typical led blinking sequence while the
firmware uploaded, and then the host error, or was the host error
showing from the beginning ?





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
