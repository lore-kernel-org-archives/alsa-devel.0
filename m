From: zeb@zebulon.org.uk
Subject: Tech doc for Terratec Aureon Space !
Date: Wed, 21 May 2003 08:37:57 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030521083757.7539.qmail@carbon.larknet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
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

Hello
Some times ago I sent an email to Terratec for the information about the 
Aureon cards. Not only they answered quickly, but they also provided very 
kindly the asked information. 

Mr Carsten gave me the Pin connections, and also offers assistance.
I think Terratec shows a very good attitude here, and this should be noticed 
!
Here is the answer : 

 -------------------
Hi Eric, 

we can help you. Here are the connections of all GPIOs and the 3 pins of the
WOLFSON Codec : 

First the codec: 

Pin 61 is connected to Pin 11 of UD7
Pin 62 is connected to Pin 2 and Pin 6 of UD7
Pin 63 is connected to GPIO of the ENVY (Pin 88) 

Second the ENVY GPIOs: 

GPIO 0 (Pin 50):	Connected to Pin 8 of UD8
GPIO 1 (Pin 51):	Connected to Pin 7 of UD8
GPIO 2 (Pin 52):	Connected to Pin 6 of UD8
GPIO 3 (Pin 53):	Connected to Pin 5 of UD8
GPIO 4 (Pin 56): 	Connected to Pin 3 of UD8
GPIO 5 (Pin 57):	Connected to Pin 2 of UD8
GPIO 6 (Pin 58):	Connected to Pin 1 of UD8
GPIO 7 (Pin 59):	Connected to Pin 44 of UD8
GPIO 8 (Pin 75): 	Connected to Pin 42 of UD8
GPIO 9 (Pin 76):	Connected to Pin 39 of UD8
GPIO 10 (Pin 77):	Connected to Pin 40 of UD8
GPIO 11 (Pin 86):	Connected to Pin 41 of UD8
GPIO 12 (Pin 88):	Connected to Pin 63 of U1
GPIO 13 (Pin 89):	NC
GPIO 14 (Pin 90):	Connected to R41
GPIO 15 (Pin 91):	Connected to Pin 10 of UA12
GPIO 16 (Pin 96):	Connected to Pin 11 of U4
GPIO 17 (Pin 97):	Connected to Pin 1 of UD7
GPIO 18 (Pin 98):	Connected to Pin 3 of UD7
GPIO 19 (Pin 99):	Connected to Pin 13 of UD7
GPIO 20 (Pin 101):	Connected to Pin 64 of U1
GPIO 21 (Pin 103):	Connected to Pin 1 of U3
GPIO 22 (Pin 104):	Connected to Pin 2 of U3 

I hope this information will help you.
If you have any further questions please give me a mail 

Best regards
 ----------------- 

I hope this will help making a driver for the Aureon Sky/Space series.
Cheers
Eric 


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
