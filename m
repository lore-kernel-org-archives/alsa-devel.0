From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: autodetection at install
Date: Sat, 13 Jul 2002 04:00:00 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D2F2730.50004@boosthardware.com>
References: <m3adoyr6pr.fsf@ccs.covici.com> <3D2EEF7A.3020406@boosthardware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010003010003010405010903"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010003010003010405010903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Try that again. after saving this time :)

I have a small perl script which I am working on. The idea is to autodetect
a card/s and create a modules.conf based on that either at configure or as
a seperate process.

Can anyone who is more fluent in perl give me a hint as to how I can
compare the output of list_pci to list_modules and return the correct
card name and module?

The script has two subs. They just parse the /proc/pci and the INSTALL
file to get the current output. It has to be run from the alsa-driver dir.


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================


--------------010003010003010405010903
Content-Type: text/plain;
 name="autocard"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autocard"



sub list_pci {

	open (FILE, "/proc/pci") 
	or die "Cannot open /proc/pci. \n Do you have permission to access this file?";
   
    for $linepci (<FILE>) {
	
	if ($linepci =~ /Multimedia audio controller/g) {
   	print $linepci;
	}
    }

#    close FILE;

}

sub list_modules {

	open (FILE, "INSTALL") 
	or die "Cannot open INSTALL. \n Do you have permission to access this file?";
   
    	for $linemodule (<FILE>) {

		if ($linemodule =~ /\.o$/) {
			print  $linemodule;
		}
    	}

#    close FILE;
}


# Output to shell

list_modules();

print "\n The modules for the following card/s can be found in the above.\n If your card is not listed below it means it is a PNP (very old)\n or USB card and this script cannot find it.\n\n The modules for ALSA USB support are: \n\n \tsnd-usb-audio\n \tsnd-usb-midi\n\n";

print " These are the cards found on your system:\n\n";
list_pci();
print "\n";


--------------010003010003010405010903--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Gadgets, caffeine, t-shirts, fun stuff.
http://thinkgeek.com/sf
