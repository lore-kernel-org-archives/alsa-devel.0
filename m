From: Florian Zwoch <zwoch@backendmedia.com>
Subject: Terratec Aureon Sky/Space
Date: Fri, 23 May 2003 14:25:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ECE134E.50005@backendmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

to Takashi:
some stupid used our mailserver for spamming which lead to heavily 
blocking of my emails. well, i hope that was the reason you didnt 
respond to my email anymore =)

anyway i tried to get more information on the Aureon hardware.. and of 
course im still confused as i dont know much about that.

with my voltmeter i could identify the following (Aureon Sky that is..):

Envy24HT
GPIO 0  (pin 50)	->	XILINX pin 7
GPIO 1  (pin 51)	->	XILINX pin 6
GPIO 2  (pin 52)	->	XILINX pin 5
GPIO 3  (pin 53)	->	XILINX pin 4
GPIO 4  (pin 56)	->	XILINX pin 3
GPIO 5  (pin 57)	->	XILINX pin 2
GPIO 6  (pin 58)	->	XILINX pin 1
GPIO 7  (pin 59)	->	XILINX pin 44
GPIO 8  (pin 75)	->	XILINX pin 42
GPIO 9  (pin 76)	->	XILINX pin 39
GPIO 10 (pin 77)	->	XILINX pin 40
GPIO 11 (pin 86)	->	XILINX pin 41
GPIO 12 (pin 88)	->	WM8770 pin 63 (CE)
GPIO 16 (pin 96)	->	XILINX pin 33
GPIO 17 (pin 97)	->	74HC125D pin 1
GPIO 18 (pin 98)	->	74HC125D pin 3
GPIO 19 (pin 99)	->	74HC125D pin 13

74HC125D pin 11		->	WM8770 pin 61 (CL)
74HC125D pin 6		->	WM8770 pin 62 (DI)

wow, lots of GPIO thingies go to the XILINX chip. so aparrently only CE 
is directly connected to the Envy Chip, the other two go through a small 
chip labeled:

74HC125D
AA432 01
Unn0219D

a 14 pin chip from phillips.. nothing big i guess. oh yeah.. the pin 
descriptions for that chip may be wrong since i couldnt see any label on 
the chip where to start counting.

i hope this helps. maybe i can try to figure out other important 
connections? (as you noticed.. i still lack some of the GPIOs)

plz.. let me be the helping hand for the blind :)

Florian



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
