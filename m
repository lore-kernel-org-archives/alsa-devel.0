From: "Aldrin Martoq" <amartoq@dcc.uchile.cl>
Subject: python midi wrapper
Date: Fri, 4 Jan 2008 15:01:39 -0300
Message-ID: <17eedd8a0801041001m3810fac6q945d2ba551e15a17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.237])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DD69243C6
	for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2008 19:01:41 +0100 (CET)
Received: by nz-out-0506.google.com with SMTP id m22so1241557nzf.2
	for <alsa-devel@alsa-project.org>; Fri, 04 Jan 2008 10:01:40 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello, I need a midi/seq wrapper for Python. I've already created some
code for the sequencer API and works great! Here is my python test
code:

--------------------------------------------------------------------
#!/usr/bin/env python

import sys
sys.path.append('build/lib.linux-i686-2.5')
import alsaaudio

print "Creating Sequencer..."
seq = alsaaudio.Seq("hw", "Python seqtest.py",
alsaaudio.SEQ_OPEN_DUPLEX, alsaaudio.SEQ_NONBLOCK)
myid = seq.get_client_id()
print "... seq:", myid, seq
print "Creating Port..."
myport = seq.create_simple_port("Processor port",
alsaaudio.SEQ_PORT_CAP_WRITE | alsaaudio.SEQ_PORT_CAP_SUBS_WRITE,
alsaaudio.SEQ_PORT_TYPE_APPLICATION)
print "... port:", myport
#queue = seq.create_queue()
#print "... queue:", queue

# dump clients and ports
def dump_connection():
	print
	print "Client/ports available:"
	for client in seq.get_client_ports():
		clientname, clientid, portlist = client
		print " client: %3d    %s" % (clientid, clientname)
		for port in portlist:
			portname, portid, connections = port
			print "   port: %3d:%-2d   +-%s" % (clientid, portid, portname)
			readconn, writeconn = connections
			for conn in readconn:
				print "     connection   to: %s" % conn
			for conn in writeconn:
				print "     connection from: %s" % conn

dump_connection() Is the front
seq.connect_ports("0:1", "%d:%d" % (myid, myport));
seq.connect_ports("24:0", "%d:%d" % (myid, myport));
dump_connection()


while True:
	events = seq.receive_events(60000)
	for ev in events:
		print ev
		print "\t", ev.data()

--------------------------------------------------------------------



I have tried to contact the mantainer of PyAlsaAudio (cwi@unispeed.dk
from the README file) for merging my code in his project, but have not
received a response so far and the date of files seems old.

Is anybody here interested in the merge? How can I put this effor in
python-alsaaudio or may I create a new project for this specific task?
Is the pyalsa project related to pyalsaaudio?



Thanks,

-- 
Aldrin Martoq
