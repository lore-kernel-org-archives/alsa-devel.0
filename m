From: Stanley Pinchak <stanley.pinchak@gmail.com>
Subject: CS4232 Playback bug on Tecra 500
Date: Wed, 21 Jan 2009 23:40:41 -0500
Message-ID: <405205790901212040s79ce94a4if4ff742a9c18bc67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6434612f330cc04610adf51
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.156])
	by alsa0.perex.cz (Postfix) with ESMTP id A69A81037E3
	for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2009 05:40:42 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so1697880yxh.2
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 20:40:41 -0800 (PST)
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

--0016e6434612f330cc04610adf51
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I have been running into the problem briefly mentioned at the wiki
entry http://alsa.opensrc.org/index.php/Toshiba_Tecra_500CDT.
Playback using the CS4232 driver in native or oss emulation mode fails
randomly.  Once the failure occurs, subsequent attempts to playback
stop shortly after opening the device and tickling the speakers
(perhaps the buffer gets filled once).  Under heavy network load, the
initial failure will occur rather soon, within 15 minutes or so of
playback.   When I am playing songs from the hard drive, the failure
takes a very long time, and when I use oss emulation and play from the
harddrive, I have been unable to replicate the bug.  The CPU does have
the F00F bug if that might make some difference.  I have attached a
backtrace resulting from the attempts to use aplay after the failure
has occurred.  I may be able to attempt to capture a backtrace at the
initial failure if this would be helpful.  There are no obvious error
messages in my logfiles or printed to the console when the bug occurs.
 Please let me know how I can assist in squashing this bug.  I
attempted to use the alsa-info script, but it appears that the
database where it uploads the results is broken at the moment.  I have
pastebinned the results at http://pastebin.ca/1315459

Thanks

Stanley Pinchak

--0016e6434612f330cc04610adf51
Content-Type: text/x-log; charset=US-ASCII; name="backtrace.log"
Content-Disposition: attachment; filename="backtrace.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fq8xhhl20

KGdkYikgYnQKIzAgIDB4YjdlMzk1ODYgaW4gcG9sbCAoKSBmcm9tIC9saWIvbGliYy5zby42CiMx
ICAweGI3ZjQ2NzlmIGluIHNuZDFfcGNtX3dhaXRfbm9jaGVjayAocGNtPTB4OWQzM2UzMCwgdGlt
ZW91dD0tMSkgYXQgcGNtLmM6MjM2MAojMiAgMHhiN2Y0Njk0NCBpbiBzbmRfcGNtX3dhaXQgKHBj
bT0weDEsIHRpbWVvdXQ9LTEpIGF0IHBjbS5jOjIzMjkKIzMgIDB4YjdmNDZiMjUgaW4gc25kMV9w
Y21fd3JpdGVfYXJlYXMgKHBjbT0weDlkMzNlMzAsIGFyZWFzPTB4YmZmZTQ5ZjAsIG9mZnNldD0w
LCBzaXplPTU1MTAsIGZ1bmM9MHhiN2Y1MmE4MCA8c25kX3BjbV9tbWFwX3dyaXRlX2FyZWFzPikg
YXQgcGNtLmM6NjY0NAojNCAgMHhiN2Y1MmQ4ZSBpbiBzbmRfcGNtX21tYXBfd3JpdGVpIChwY209
MHg5ZDMzZTMwLCBidWZmZXI9MHg5ZDU1ZjJjLCBzaXplPTU1MTApIGF0IHBjbV9tbWFwLmM6MTg2
CiM1ICAweGI3ZjQxMmQ0IGluIHNuZF9wY21fd3JpdGVpIChwY209MHg5ZDM0MjIwLCBidWZmZXI9
MHg5ZDU1ZjJjLCBzaXplPTEpIGF0IHBjbV9sb2NhbC5oOjUxNgojNiAgMHgwODA0ZDRlMyBpbiBw
Y21fd3JpdGUgKGRhdGE9MHg5ZDU1ZjJjICIhXDAwM1wwMDJcMDAyXDAwMlwwMDJcMDAyXDAyNVww
MDNcMDAyXDIzMFwwMDJcMjM1XDAwMlwwMDJcMjM1XDAwMlwwMDJcMDAyXDAzNVwwMDM3XDAwMzRc
MDAzXDAwNVwwMDNcMDAyXDAzMFwwMDMpXDAwMzxcMDAzbFwwMDNcMDAzXDAwM1wyMzVcMDAzXDAw
M1wwMDNyXDAwM1NcMDAzfFwwMDNcMDAzXDAwM1wwMDNcMDAzMFwwMDRHXDAwNCVcMDA0P1wwMDRc
MDA0XDAwNFwwMDRcMjMyXDAwNFwwMDRcMDA0XDAwNFwwMDRcMDA0XDE3N1wwMDQ6XDAwNFwwMzVc
MDA0KFwwMDQtXDAwNFxmXDAwNFwwMDNcMjE3XDAwM1wyMzdcMDAzXDAwM3NcMDAzUlwwMDNQXDAw
MzxcMDAzN1wwMDN5XDAwM1wxNzdcMDAzXDAzMFwwMDNcMDAyXDAwMlwwMDJcMDAyXDAwMlwwMDJc
MDAyfFwwMDJcMDAyXDAwMlwwMDJcMDAyXDIxMlwwMDJ2XDAwMlwwMDJcMDAyXDAwMlwwMDJ1XDAw
M1wwMDNgXDAwM1wwMzFcMDAzXDAxNlwwMDNcMDIxXDAwM1wwMDJcMDAyXDIwMVwwMDJMXDAwMjhc
MDAyYVwwMDJcMjAxXDAwMlRcMDAyOFwwMDJUXDAwMiIuLi4sIGNvdW50PTU1MTApIGF0IGFwbGF5
LmM6MTQzMgojNyAgMHgwODA0ZGMyNyBpbiBwbGF5YmFja19nbyAoZmQ9MywgbG9hZGVkPTAsIGNv
dW50PTg5ODY2MjQsIHJ0eXBlPTIsIG5hbWU9MHhiZmZlNmE4NCAiR3VpdGJveCBOIEdsYXNzZXMu
d2F2IikgYXQgYXBsYXkuYzoyMTcxCiM4ICAweDA4MDRmMGI5IGluIHBsYXliYWNrIChuYW1lPTB4
YmZmZTZhODQgIkd1aXRib3ggTiBHbGFzc2VzLndhdiIpIGF0IGFwbGF5LmM6MjIzMQojOSAgMHgw
ODA1MTRmMSBpbiBtYWluIChhcmdjPTMsIGFyZ3Y9MHhiZmZlNGQ0NCkgYXQgYXBsYXkuYzo2NDEK
KGdkYikKCg==
--0016e6434612f330cc04610adf51
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016e6434612f330cc04610adf51--
