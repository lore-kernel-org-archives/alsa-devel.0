From: David Stuart <dave@sipquest.com>
Subject: buffer questions
Date: Mon, 19 May 2003 19:35:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EC96A3F.4080802@sipquest.com>
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

Greetings All,

Having had some of my previous questions answered, I now understand that 
a harware buffer is made up of periods, a period is made up of frames, 
and a frame is made up of x number of samples, where x is the same as 
the number of channels.

But, I have further (newbie-ish) types of questions which should be easy 
for you guys to answer :)

o If I make a buffer in my program, does it have to match the size of 
the hardware buffer? Is it good practice to do so?
o The readi function takes an integer representing the number of frames 
to read. Is it a good idea to read an entire period at once, all 
periods, or just a few frames?
o How does one determine the size to set for the period and the hw buffer?
o One of the alsa tutorials 
(http://www.equalarea.com/paul/alsa-audio.html) does a readi using "128" 
as the number of frames, but the buffer is declared as "short buf[128]". 
Does this work because there is only 1 channel?

Dave



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
