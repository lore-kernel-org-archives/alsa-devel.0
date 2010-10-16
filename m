From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Sat, 16 Oct 2010 20:52:02 +0200
Message-ID: <201010162052.03180.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<1287237520.2113.11.camel@laptop-alex>
	<201010161830.31603.julian@jusst.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_SRfuMCXF2vupyvq"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id B932C24545
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Oct 2010 20:52:05 +0200 (CEST)
In-Reply-To: <201010161830.31603.julian@jusst.de>
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
Cc: Clemens Ladisch <clemens@ladisch.de>, Alex Lee <lee188@singnet.com.sg>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_SRfuMCXF2vupyvq
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Am Samstag, 16. Oktober 2010, 18:30:31 schrieb Julian Scheel:
> Hi Alex,
> 
> Am Samstag, 16. Oktober 2010, 15:58:40 schrieb Alex Lee:
> > On Sat, 2010-10-16 at 12:25 +0200, Julian Scheel wrote:
> > > Thanks, I implemented them the way same you did. So for get_min/max/cur
> > > I always return 48kHz and set_cur simply does nothing.
> > > Now playback in general works again. But still the rate feedback seems
> > > to have no impact on the data-rate. Also the frequency value shown in
> > > proc-interface is unchanged. When rate feedback works, it would
> > > probably be slightly different than 48.000kHz?!
> > 
> > OK, you are getting close :-)
> 
> I hope so (c:
> > One debug technique we have been using is to do a USB wire dump, using
> > something like wireshark.  This way you can see exactly what goes on
> > between the PC host and the device.
> 
> Yes, using wireshark is a good idea indeed. And it immediately turns out
> what the problem is.
> The device sends ISOCHRONOUS out packets on the feedback endpoint (5,
> respectively 0x85) - but when I try to send 4 byte, the URB length is
> always 0. If I only send 3 or less bytes the packets look fine.
> I thought it might be a bug regarding max packet size in the at91lib and
> raised it to 5, but still only 3 bytes can be send. Any clues what might
> cause such an error?

I digged deeper into this. Actually all 4 bytes get written to the UDP_FDR 
register for endpoint 5 properly. Also the TXPKTRDY flag is cleared and set as 
it should be. So at the sending part in the firmware everything looks fine. 
Now the question is, why do the package have a length of 0 then?

I attached two wireshark dumps (filtered on endpoint 0x85). One when sending 3 
bytes on the feedback pipe (set max packet size to 3 as well). Another one 
when sending 4 byte (max packet size set to 4).
I also tried sending 4 bytes, when max packet size is 3 - as expected it get's 
properly split up into 2 packets. First has 3 bytes, second 1 byte. Really 
odd.

Maybe you have an idea when looking at the dumps?

Anyway, as 3 byte feedback sending works, it might be worth to test the 10.14 
patch by Clemens to see if the feedback loop itself is working properly then. 
Can you point me to that patch? Is it already commited to current head?

Regards,
Julian


--Boundary-00=_SRfuMCXF2vupyvq
Content-Type: application/x-bzip;
  name="3byte_feedback.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="3byte_feedback.bz2"

QlpoOTFBWSZTWddF+CUAIZz/////7KHHf///7HzeuXf+0F/v/sdP9Nf+/v7jTS2f///u4AmfTxMO
JgJEsEs4oAAw2FEGk2oyKY0k0TNJP1JpsoaAABoNAaANAaAAAAAAMg0aAA0AaAAAGgBoA0xU/Uqk
ZMTRpoGg0aNMJo0ADTTQaNAaMEyYgaANAMmQ0yNGEepoZGhoNA0MRoemifqEbUQDINAAyaYg00Bo
yZMEyNGhkNAAaMg0YQyGTIwQ0AGg0xAYI0BoNADQADPVU9RJPVI2o0P1IAA0AAeoA0AAAAADQAD0
IAAHpAGgA0AaPKbU0A00Z6oeUQDINAAyaYg00BoyZMEyNGhkNAAaMg0YQyGTIwQ0AGg0xAYI0BoN
ADQACJJKp/6kJPSA2p6jaQaDah6gAA0AAADQaAaAAAAAAAABoAAAAA2oPU4M0BQYHDoPDCNCB7qg
MGCgxUQDEMudBbcMOUwqmFMSEZlJCbB3wYkyxmJMh4hpMKXJcI1SSUkJszOlqWgiovAzcWxwcz7O
MAIE0ulgkEhVVVVVVVVVIqqqqqqqqqohFVVVVVVVVVVIqqqqiKqqqqp0dlkuC2SJl5iIAEIARAAB
x+Zk7n34kklTqNb8i+ESqwJac5ziSSSZM81VSVJoiABOMFoRAEuRAAigBCIAwEYQAMlBB04jpBGw
IOEShQZZQGCg2AYwUgJCI/LLIOAjFSANCYRGAMIAwIRQIqkAhFNeFBirpkEGCqITFVmonTCpJhkM
MtAtBIkOmSG2UQww0QkqdOnRSIRIQaVIMhAlFIkFgMIlJBgOmGWQFSDJpsMAunSSVMlkswqoQotR
TRYlRARHKysrLx8u4oN73ve90QUta173uoLt0EFRyICApkIIEgECIgTbsmmlt8a6Gjo6FJSelJQW
kROcmwUox0+dMQJwO7kkwhNoqNGuI23VsrGKzac4EmwPGNWrOMozWJud4kk0saTBEAQ22Wm6tL74
xizzZVnFbYmWClKG62hUmx3ckkTnGJrW83XVsJNs2nOBUwtnGrVnMynBVq7uSTaxjIIECJvqQEAA
AIBAAkAABADWIgATPCIAiogFiTnaLbxdfVxTKTKTKAtkMVrCxxgngwC7KTEJSS5kwMKOHcTFl6Xi
UrAGSjCbsXxnJckyMDYDRiNYYGPjY5hcQXb4MiMigsgJoYuP8fY9V7OJQGyCDBQdRm5ubVVaqtbN
1Gp3QlSqqXZ3VVKqTJ3cQJhBTqkAQBMN9919+FmZmZmgzMzYQAiDXbPbabW7LU6dAEATNx48aqSF
U6THnY4KTCBLM7kqVUmLu6qpWBOyrdddhw4WZmZmVb2ve+xD0nSyZlpOW8X/dX6f83FBzlAdFnKS
G5wCoDKKGo0wCoBIDIJIG0ZmlzJVrGlq2QZMkjBSNrpNZ5+v+Lo7LrqqpMFNa1qpUqtltzVzc3Nz
8/PlJJElJODzFAUBV5FUKArGkE6HZ8Px9twbc6KoCrrrsJhOJJJOOSta1r/RX17qfnkmKkklpJJa
TjYJOKAoCu26i/0l9ebbkkkkJkktQFAV4XwYGo3HASUkkkkSUktVACtNtPP3F/A25LrrrrsBKSTs
dgTf6faehe4ZMkjb4V32SS6T0sDs9qkm2+FdzRkl08O+wfV4BxikYkJe2zN+7kuXVoBn0PdhDrPT
1fffPtdpGKiMVZmbaO7M4VXeLQZ/R+/otnttRrtVq1VYwnOc4znPY0pSlJ0lJRKTFqUpnf4Trv1w
fm/j6P9bclrWta1rWLdrWtrtIT7AHXiqArRduSlAddu0lAPv4pK53nNVJrbSGCD2+fJo8aT51Bw2
aTywR+D4ZMcEcjzCjGVTXZ8mLX5MV1EGE5tkslaEQcW40zd4g7Dq/Yf50aZu4IiIiICD2X7jM39C
ZkAAH3JbJeR0ZyuWbbllttJLJeLY3+ZNfd8g5XAa8YjJZKNVSADlyWso5EEFNJUtb29ZJQICZ+I2
z/fZmYdPyzi6E1ls+vbJL03MNu4G2+IACOX/AzCOu5pmEEBFAOk5BmEREddzTfvNdiJoSH4fq40k
a5dYJESCkRC6zWCREgpEQv+prqiLAIiJESa6oiwCIiREnN4TbawWKiKgqbbRIWKiIlRPpek+d17M
zg4EqoipQDg4EqoipQDLLJcQIIkWhlxAgiRaGkyJAWKiJERMmWpAKqIkTkzXtPX9qMwEsslREBRH
dvAHYzXUIgAtsl7Gaaen4TSSXX3ptn89jsvymtk/H0Bu45rxkkvgvLmmRxcbsjrepN27s+I/t7M2
24OE0mPNcR5Pcbbej5JmR6L33Uma+x6Y0wPgcJme/lksl00iI055pkQQRtvMwgAj1nWmZ9T4fYTT
Rp1mGZkzM0DRZbbTYTTbTDbRaQZbaaTTQbKTSTTCDKdNNBIthhlNhsplotBJoNEJhhoNsttFBsFE
0Wym2SmGymWG2mkwUU6TZIScgJJP3JetypN7iEyDOP+1snYoIO+GhppNTvH9cJUq2iFMT6+ZJtZg
g2tJzPjanRHVduMzi/4ZkHBwaM0JB67hMzrPsGmR/WaaQQ4zQW2Soj8/cTTA5/VnOk/BOdOTiyFh
YS8qXXVeqthbCTad7kzRSSEJZrLtLdyQhCTW7IJuiSQQkJCiQEuXL2iEiSJINxwwjdSLYSbTdJmi
kkISzWXaW7khCEmt2QTdEkgQhNISTf0EHHjQcfTSIiPv840yOZ0Rmc/tZmb/3mmHSeNNMCN+PJa0
kl1QfBkgAtWoUHWWtZVHTig+QhqxQf/F3JFOFCQ10X4JQA==

--Boundary-00=_SRfuMCXF2vupyvq
Content-Type: application/x-bzip;
  name="4byte_feedback.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="4byte_feedback.bz2"

QlpoOTFBWSZTWWW0eCgAFmV/////7rbHv/5lTBTf/v5BCF1Xf/XcIMNfNJ/N7JSlDT/04AbfGhIl
V4VBsWJlVApBgENGJoDJphMmmQAYRo0wCYAmEGhkDEyAMAAJiZMBMBNA1PNSRNFMJPUBo0PSNAAA
BoAAB6nqAAAAADQaNAGmjQAABBgENGJoDJphMmmQAYRo0wCYAmEGhkDEyAMAAJiZMBMBNAlPVTU9
RJjRPQIDQAAAAAAAAAAAAAAAAaaaAAAAQYBDRiaAyaYTJpkAGEaNMAmAJhBoZAxMgDAACYmTATAT
QFRRImhDVPynpR5JmkZNGhoGTQyZPUMmjTGpiAAyBk0AZNBibUeiaA0ZNqYam9U4iD4lLEOgQWUg
skkZINZBv8GHG3vZcZvMb7LOc8dvN9ngaNGmmm+4G4zyGjRpppx3HabrTkcjncH9vA5JBwkQezEH
CIKWVklbyd19Ov6nZ8BkNXDCYkhhjjiSGGGGOZJWS6ZC75bBbBbBbEsmEKkm6IPlEGCDIXAgqEYQ
omCCyGAoqFTJBZMBahUwQUm7Qg6cQWIJeVpjOWLjDOHZjUsxItBoiaG0EUaaihGohgOwIEKWLRS0
TYkIbRYsNhLKKNlrkuMpJIOHht6bht0iINNM6aIQ4bCR2AUhEoKRJZJTaqSQmwgtILISRj2vL5XU
Z005nU7OZc4y1a9ey7M6bWvZsZBau34vbOqzZaNpJCSs2Oa+a+Oas0kJM+GfQ3orS4bjNQAVZs2b
O8r5ZZZQBSQxz3L6mnlqSDwvljlk7mOzZt4xm6pIDmkHbkGEmvb2m3suzW226zuqlSve99JaS00a
ipUsb3vqraq6NNUqVKq01pqtC03t5E1cjjbWkkROapVstttWyqsjpofd/Nv++pJWslbX2mvuOO3O
43MYVhjiwMcccRwrDHHdJKAKtVbGqspUSswshVFhWEFhC0uIFRWFYQRYNx47zF4ECALOtbVrS3lb
W8mUp06lShonSp1KlKholOnTqdevsFq1VWiVYrCsMIKKiiwtYrCsMIKKiiwsggC7uLPyNra2spUE
Da62trBDC+GJAAq+GKAyzt4524BosrK2miKiIqQq2UFkiKiIqQqyDab3W4OuTSskr3bq7YQuklzG
8+TSBuDYQqyta2xvPi0Jtg23CkrWSWbZ28zsG5IbO2zyNz4GEMyVlbZ93npG5kwhSSXA7nd6N+96
9F74ABg241VS98NG/+zut3SpBUkqpVbHsbTfZ2qoklIJVbHr5t9oqpJBUqqFYbHraN80FSSkwqsu
44VKKJuJO9vzFVZaqvjKwqqsswrCy1VIiIiMMIiMKIiIiIjDCIjCiIiIjDCMSXzHnKJKqr5C6KIg
JDuzeHFOOUprhC6OOcgnNVFRVVFfK6DuniNIg1UgtttVfLEFwq9BrdsslV200227rgl569BfQZcr
GyOARA5YQyRAm0QjkAICkhIQtHCCAtBpwjTYNRCGyEbHAccCAKMEANm4uc7hB0HdNjeboQfzdO69
5yt5tOS5oQbIOChB+B1bW4WrVakFtt815z86ZOaiKiojBFikOAOkXopTUVFRERFVG7K8wBclKYio
jckyuK4nNecc86Z+ly3LeU57xnJbm6vlucwQZqrznmMQgzaoqsjxFElVRFRIgBGAFpkyiRbfNQXC
+OgxjnuOzmNSDpNaDKHPWBe/gfErj9nf8GK5VDRKvK8sLLylqb0pUlFV9noPSXZeGog/y71wOJ6y
ST1rLatLJIqohbLatLJIqk++5j0XpPTdF0nE/Y/0695Dg5XqYxb/57tjPpP+MZ+48l8B0Wmq32ji
dEQbjqnWOqfDcDbDcvv3qPXdJ5nsOJ2bpNsjcVVVUgv8SOj6ctqtCTE20SxmEytYGSxMy2q/7Hoq
VbLbbVszNESxpCaLoyFIEInUVRURVVWpAEEMXiwrMvLZboSD8dIOIg9g4iD7RB/8XckU4UJBltHg
oA==

--Boundary-00=_SRfuMCXF2vupyvq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_SRfuMCXF2vupyvq--
