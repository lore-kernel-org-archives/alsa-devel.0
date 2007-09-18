From: Anders =?UTF-8?Q?Bostr=C3=B6m?= <anders@netinsight.net>
Subject: Bug#438118: [alsa-devel] [Pkg-alsa-devel] Bug#438118: alsa-utils: aplay non-blocking mode isn't working
Date: Tue, 18 Sep 2007 09:41:48 +0200 (CEST)
Message-ID: <20070918.094148.-529052212.anders@netinsight.se>
References: <20070816.094636.-753684517.anders@netinsight.se>
	<20070911160811.GD17585@frodo.home.lxtec.de>
	<s5hsl5dco8l.wl%tiwai@suse.de>
Reply-To: Anders =?UTF-8?Q?Bostr=C3=B6m?= <anders@netinsight.net>,
	438118@bugs.debian.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Tue_Sep_18_09_41_48_2007_313)--"
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.438118.B438118.119010135521027@bugs.debian.org>
In-Reply-To: <s5hsl5dco8l.wl%tiwai@suse.de>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: tiwai@suse.de
Cc: riesebie@lxtec.de, alsa-devel@alsa-project.org, 438118@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

----Next_Part(Tue_Sep_18_09_41_48_2007_313)--
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

>>>>> "TI" =3D=3D Takashi Iwai <tiwai@suse.de> writes:

Hi!

 >> Hi all,
 >> =

 >> can one please have a lokk at this? aplay -N isn't working for the
 >> OP.

 TI> Cannot reproduce here.  Could you _post_ more details?

OK, I've tested more, and discovered that the problem seems to be that
the end of the sound is cut in non-blocking mode. And if I play a very
short sound-file, I can't hear anything. Blocking mode works fine.

When using non-blocking mode, an strace contains "ioctl(4, 0x4144,
0x2b9f785d8000)        =3D -1 EAGAIN (Resource temporarily
unavailable)". Blocking mode never contains the EAGAIN response.

I attach two files. When playing halt.au, I can only hear the start,
about as much as "ha". When playing metal.au, I can't hear anything.

System info:

ASUS A8V Deluxe motherboard with Athlon 64 3500+ CPU
VIA 8237 with ALC850 sound
Linux 2.6.22.2 kernel for amd64
Debian testing amd64 with:
alsa-utils 1.0.14-1
libasound2 1.0.14a-2
libc6 2.6.1-1

I hope this helps. Please ask if you need more info.

/ Anders

 >> On Thu, 16 Aug 2007 the mental interface of
 >> Anders Bostr=F6m told:
 >> =

 >> > >>>>> "ER" =3D=3D Elimar Riesebieter <riesebie@lxtec.de> writes:
 >> > =

 >> >  >> strace aplay -N :
 >> >  >> =

 >> >  >> ...
 >> >  >> open("/usr/lib/alsa-lib/libasound_module_rate_speexrate.so", =
O_RDONLY) =3D -1 ENOENT (No such file or directory)
 >> > =

 >> >  ER> This file is provided by
 >> >  ER> libasound2-plugins: /usr/lib/alsa-lib/libasound_module_rate_=
speexrate.so
 >> > =

 >> >  ER> Please install libasound2-plugins and try again.
 >> > =

 >> > Thanks for the suggestion.
 >> > =

 >> > Unfortunately, it didn't solve my problem, no sound when non-bloc=
king
 >> > mode is used. New strace:
 >> > =

 >> > strace aplay -N :
 >> > ...
 >> > open("/usr/lib/alsa-lib/libasound_module_rate_speexrate.so", O_RD=
ONLY) =3D 5
 >> > read(5, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\20\22\0".=
.., 832) =3D 832
 >> > fstat(5, {st_mode=3DS_IFREG|0644, st_size=3D20848, ...}) =3D 0
 >> > mmap(NULL, 2116136, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRIT=
E, 5, 0) =3D 0x2b9f792fe000
 >> > mprotect(0x2b9f79302000, 2097152, PROT_NONE) =3D 0
 >> > mmap(0x2b9f79502000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_=
FIXED|MAP_DENYWRITE, 5, 0x4000) =3D 0x2b9f79502000
 >> > close(5)                                =3D 0
 >> > ioctl(4, 0xc2604110, 0x7fff3269dec0)    =3D 0
 >> > ioctl(4, 0xc2604110, 0x7fff3269dec0)    =3D 0
 >> > ioctl(4, 0xc2604110, 0x7fff3269de00)    =3D 0
 >> > ioctl(4, 0xc2604110, 0x7fff3269de00)    =3D 0
 >> > ioctl(4, 0xc2604110, 0x7fff3269ddd0)    =3D 0
 >> > ioctl(4, 0xc2604110, 0x7fff3269ddc0)    =3D 0
 >> > ioctl(4, 0xc2604111, 0x7fff3269ddc0)    =3D 0
 >> > ioctl(4, 0xc0884113, 0x7fff3269dd10)    =3D 0
 >> > ioctl(4, 0x80184132, 0x7fff3269dc70)    =3D 0
 >> > mmap(NULL, 49152, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) =3D 0x2=
b9f79503000
 >> > ioctl(4, 0xc0884113, 0x624e88)          =3D 0
 >> > ioctl(4, 0x4140, 0)                     =3D 0
 >> > ioctl(4, 0xc0884113, 0x624e88)          =3D 0
 >> > read(3, "\377eO\333\337\370\344}\335_\377\330^l\356\361`j\336_l".=
.., 1001) =3D 1001
 >> > read(3, "n{u^\342zl~e~_[\365_y\362_\363\350\337n[\347nmi`\367y\34=
4"..., 604) =3D 604
 >> > ioctl(4, 0x4144, 0x2b9f785d8000)        =3D -1 EAGAIN (Resource t=
emporarily unavailable)
 >> > close(3)                                =3D 0
 >> > ioctl(4, 0x4143, 0x3)                   =3D 0
 >> > munmap(0x2b9f79503000, 49152)           =3D 0
 >> > ioctl(4, 0x4112, 0)                     =3D 0
 >> > close(4)                                =3D 0
 >> > munmap(0x2b9f785d7000, 4096)            =3D 0
 >> > munmap(0x2b9f785d8000, 4096)            =3D 0
 >> > munmap(0x2b9f792fe000, 2116136)         =3D 0
 >> > exit_group(0)                           =3D ?
 >> =

 >> I have no idea, so forwarded to alsa-dev then.
 >> =

 >> THX in advance
 >> =

 >> Elimar
 >> =

 >> =

 >> -- =

 >> Experience is something you don't get until =

 >> just after you need it!

----Next_Part(Tue_Sep_18_09_41_48_2007_313)--
Content-Type: Audio/Basic
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="halt.au"

LnNuZAAAACAAABI6AAAAAQAAH0wAAAABaGFsdC52b2P/////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////fHV1////////////////////////////
////////e339+///eXb/////////dv//9fX+dXV1//j19fX19Xd8b3Z7fX17/3NudXn49fX+/X11
cm5ucH7/+fV1fH51fe7u9fh5bnT///r+dXX/9+7u9m9saW578/Tx/nt3bm7+fnV9fXV++2xpev/s
5/RsZmRoc+zi2+P4aWRkZnp3ff12de7//29ua/fy7vd1Y2JrbXV8fmn++P/18Xl1+/Xz5vr47Hb1
7+nu3/hqZWp57eZqYl1UWGFYW1dTU1ppaWleWVtfZHD5//947uXd0s/PzdHW3+TYyb+6tb3PWT45
OT1KX253+XFuc2tdUUxJSlBUXl9fXFZZX0xGREFFVnLv9V5WW/PPvru8wcnIyb2xrLHHPSwnKTdf
wMHL6VpY/+D6UD04OEJez8fP8F1ecl9FODQ3RODGw9hXTV7Ita2utbixueVBLSEjKjjNrq2xvepQ
RTgxLi42Ur60s7j4QDQvLzlM4sPD3FVESHu7rKejprY9Kh0eJC7irqqutcRoWkQzLywuO9y3srLU
RTMtLzz+yL3JXUQ9QtavpaOl7zkgISUrUsauv769wMzNRDAtKzFWu7e55jszNj5kxsTT4UxJWM21
qKe8ZSciJyxsw7LdTulq3M7bMi4qLu60r75mLSgrO9GzsMTPXe69qKvYPiEmKTCxqanJXC0tPU/n
ODMpMcyrrLBIKSgsOcutsri7u6rT5CwkKioz3qarrNE7Lyk1Mjw7RsrFttRRNzQ+7a+sq69gMycq
LDrU071jxcK9wNo6KCstM8aysbdKNyw+z66srcM9KCosPdR6y/k/vbq02H0pKi0tUryy2dk/SD/O
w66suFQtKCwuYurCwUnNz7bLzjQpLS4/zLC9wEQ/Nm2/rq2zUikpLS7NxLfLPW/dusLIOCksLj7X
scPJPkI26Lqvra9KLCktLnjFx7pc3d660/I5Ky0wPc26yek/RD1dtq6utVEtKi0u382xv+rU3cTN
XjgqLS9C4q7L2jo/P9StrrfNKiouMMu+uNNER/jHvMxBKywvRdC27Wg6SUy/q67JSykrLjS7urJ5
Ol7pwb7+MisuL0y8t3ReN0zxsa6y4ioqLi7Tu7HMOTz6u7nGPistL0LIuepuN0dys62zxCkpLi/a
yrnNOjbev7e8TystL0VwuelrNUxYsq61xiwqLzHB0r7oNjPbvrW4TywtMEv+vXVfPllktq261i8r
Lza32MdnNDfhu7i4SiwtMzrev1JOSOfOsbDMTSotMEu8xsJMNzvLwL3JPSwxOHnu2UpMW7+xr8FE
KC0vRL24y18yOlS9v8lDLTY7UN3O30tbyLWuyT4oLjRXuLTSPTM4Vcm5vVc3QDZHT/1ZY+XEtLh6
Ry0uNdXCutlINENbzb/FSjw7OU7fc+zt1b+4wu0zLi9Nu8XB2DY7Ol/awtlWQD886+D17+bYv7dv
SDkuQGe6wr1HOT9J68/GWElAOkxq397Hw7S0aDsrLjF/xrq6XURBSl/n5U1ASEtY0OvR39O/uldL
Ly45ULbAvlo5QUDuzMXaT0o2P2Ld18nTzLu9ZEg1MT/awcfGQj1HT9vOzl5GQTJH6cbLy8i5ylRA
MC44fMq5wE5AP0VYzstkS0Q9T+53zM/NxsDkUTw0NlW/yMbMOEM+XubJ2m5PSDRcY83RyNzNvM9M
SzUxW9LLzM06QE9W1MjZUUpGNktz69bO2sKs7/80Lys+0NS220dCVUvNz9s8TzZETd9Vwt3O3rq9
VUo3LE1axtLEPzhXWti/zU1JPztDXn7ew+rlw7jJ7j8xLEVUxr/GP0ZUaM3HYk4+PztpWu/p3G3U
u6vJ2S0rKzvoyLnQSVFT8cjWbTw7OktM32zQXeL/xbi5VlwtLDddwMnBQ0Bja8e8bUc5PjhBXFdw
1dbLv7qta1AvKS072cS5yUzvZn7PeEdCOU5FZ15N+Vnbxb+5tG9XLi0sTPzTychQz9rc10Y/PENN
R+NRV9vf3cnNuq/3TzIqLTvrz7XCXcNbe+xaQ0E/TkpyR05dbNe+vLOv0nUnKCs63s22vvvYVmP0
REE6PEhg9m9IX0zXy8fKvrRpUzkqLkFLyby74cpYTHZFQEk/RU9fTVvT1tjK9ce2rkNDKSkvPdS3
rNPoVj9FbU5TQkA6fEpb7d1OxeK+va93QTQoKzxPvrW5X9FMSvtjQ0c7R07ZT/9ZWFLM+sTGt7s/
Py0tNT/hv7TA2N9JT1Q/RkU/33rbTVpJWtvgzMG+slZHMCotOV++tbfc00NHUExJTj5pW9ldaUtO
WuXYw8rFtj9IMzEuRlLHvLzjzE8/Uj5STkZQa9JHakpS9Mrav8vAtFrzLywrPF7DtLvY3UJDVUhY
Vj9JSNdPz01NV3bnwL+7s19cMCoqOk7Fs7vR00xF+UJHSDxOT81qzU1HTVdswsbMzMNfTz8vLkk+
yLi3wslNO0U3QFtNWdftelNUS+Dpe8rfz7i8R+4vJy42aLuuwsFNPUJLQPhITERt9877TUFJPNrH
v7y+v1/+My8vPUC+vLjDzlJDRzdDS0biatD89kJCSlfuxNnG28+/W8c5Li81T8jSvsDoPD89Plv6
T1dL7FrpTUlSS9/Jw7vBx8ZEXjMuL0Jkxre/w9lFQj05S1tR6N/Q9Pw+PlJd1sTOx8/FvmjONSws
NVPFsbq98Ds+OT1Y/lBcVdvpzUxKQT7+08W9wMbD2kJPOCw2N2zBuLu+Zj9BOD1TXtxv317dSVBB
RkLT1crI0dHLs0n7OC42NUzMub6+8DtAPj/d3Vx8TWZt2k5ZSEBn+dXEydXOwGZYYTgwMC1dyL27
vlxLTT5b2FntQEU+03/PZz4/VVTJwsnL2dnHbnlOMy81NvS6trrCU0FIPV1zYllOUlvR3uFWSUNN
U9HOzdLh48Pm3l42MjU4a723vL9ORkhDa+BgWkhPUNLT0GFCPUhN0cfF1fRkb8PLxVY3LTg7/by5
vs5DPkdJ8dbpT0dHS8/Fw95IOjxJ78rHz+BqYd3HvM7jPi80PlvIvcjfV0VL79zO21JBQUplyMPP
Wjw6PVnPvr/aZUlQbMm5yNZINzI8RNzIyOJzTF/zzMnUX0E7QETvz8Pa9UJESPXMwct+UUhLX9XO
y9HSXFFRTExpZVNyaWvd1NXX6mRYV1JUZnz97eD1721bWlxpfeLmdXJm9OnTzMG94HhIOkE/TWTk
8+3t7s/LxdDuTUE+P0tg2c/d22d1XPTp3d9zX05RV2Xg1tLd+2FcZefU5O5aT01SX+vW1+VvXl1n
8OHf9mBWVlxs4dnb6XRjXV1YWFZdbv7p5OXp5OPb0cvBw9/yRz5IRFFldV9lYH7TzsTN21dMQUZN
Wf5+dXZt6t7Oz9DjX05HSk5ab/R/ffPu29jW4fVjW1xf/+rg9Xdtbvfu5PZzXlZZXfrn29/ofG5u
b/32e2hjX2N68ODh7nNiXWFufv94bnB1/Ovp6ezp6d/Sy9bj605NXk9dflpeVlBj9ePR1d3tbmRu
cH19a2BYXWB74t3e6Pt1bnn//3ZlZGRkbHz++v99e/95//////Xw6enp7u7z9fv//3lubnVuevf1
9f91b25ubnV7/3V8///39fX19fz19fX19f51b25uc3V6//37/3VvbWlpaWludXz97u7p6enp6enp
6e7u7u7y9fn///////n/e29pZ2RkZGRpbHV6//X17u/1/////fX19fX19f3//3d1dXV1dW5ubm5u
bm5ubnV99fDu6ezu8PX19fXz7u7u7u7x9fj//3V1dXV1dXv/////+/X19fX19f/////////59fX9
//92dW9ubm5ucXV4//////////////////////////////////91dXV1df////X19fX19fr/////
///++v///3Z1dXb///////////94dXV+//////j///////////////////95//////////n1+f//
///////1/f//////////////////////////////////////////////////////////////////
///////////////////////////3//////////////////n///93fXv////19fX/////ef//////
////////////////////////////////+PX1/v//////////////////////////////////dnj/
////////fHVuefh1//79725k+/Fpe25edHJn6vrvdfjp7W1q6XZwbG5sde5s93Fi6e73bux67v91
aXn1aXD/dvp7cX7v9n568Hx7/nl///lwdHZvdv72dW/sbutl/3Z2/Gp+cX1t927+fmx5fG7vcf/u
ePV1emr9a/Zrc256/3hvf2l+Zv51bn1udXVzam95eX5t+XVwa2//anV1dXJ6+HV+eHn2b3VvcXtt
fW78e/58bvNxfnlu9nV1fXt2eHl2enhscXhwfm78dfhxdH1w6m/7fW//bPpveP//+/15+3b4eXZ7
fX76/Xr7dnv6fnr///929Xt3+v99e/Zyefd1ffd6bnt8bvv9bnv+////e33/enX//278/HV5/XX+
fnJy9f51/X51/Px2////+nh1e/b///f///j///////93d/l2eP//////en7/////eP///3V8////
/////3l1//////////////////96fv//////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////f///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////

----Next_Part(Tue_Sep_18_09_41_48_2007_313)--
Content-Type: Audio/Basic
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="metal.au"

LnNuZAAAACEAAAZFAAAAAQAAH0wAAAABbWV0YWwudm9j/2VP29/45H3dX//YXmzu8WBq3l9s8HVw
ubi/tuZCLi0qKzRB0cq+r66uXSwkIClGpqesszIlHzRQxaWfrbPsKh0iKzhOwNc/T9PCrqq30M5i
OUJMdEVCTkJQP0JO2rnO1t5HRS89OThLOUJJ1MXHva+stbSzd1Y1MCopNDNeaMPN+e032Untukj8
Pi8wLFpZzr23r763x07QPTEuOjIpKlRGRsdnzby/yUa42D1LQu46XW41xnNRQVTGMj1fSEs+PjQ7
VkZGvq64ysXEV21TOkZETT07u2llyL/NT9poRus/OjFBPik/alTy8L7HvbfQy8HEVUboPTxAV2RI
zeRZ6XhDRmxZPTpVTzlaRll3xeJDxONn+k/aOd5YOE9GeknXwUHY9HtCP3w0Q2lGUFzuTEdjfE7l
wuhZTm5IQlU6UFDlYju4al/cW9dHeG482k9SR3/NP3LMZNXk0m1f3T86ZVBEQ1RcSl5rTF/v4UdU
20RN+mBaS8/Wc8bZ6WTQaTvdW0tMSOQ6YGY9X2JnSuzJR1JY61FT8Exf4F5H/NR0XFHQaVTrQVFK
V0Y67ElfZ2rZPMp5Sc9R609+yD5d825WVXtFTtFLTVxmY0tiXj3c7154Y9dWZ9BTbW/bUkvXTl7b
YXpS235A+3xdZv59THHqRFZp4lRg31puzN7o5OXbZGtxR19XTkVGSD1YZE5rSe1nR+Ft/FTh2D/8
0E5j3MFP38hOUeJoQkraSj5haUxi5HRL2ctPbM7ZTFLSTkzqb1dm0k8+1G9EVX9uPl3iR3PO6GDl
xE9rw/BsZd9JP24/PW5sX1nw1lBu6ldZX/ZDUc9FWu7Qb17F8mbQ/WNL125GePRdTN/fRmfYTUzz
bUFR1lJG0NpPbNRSTNXwR+fmXU5j4kNf1lVleNxhYtJcWPTbVUf2V0d9dl1f6NZNf8hnb+rbTk/f
TlPj7llU0V1P3HBcb/J7Vnf9S1/pYU9a4FBg3l9xft/0Ydl1bG17d1NidV1jYm9c7vNaYdvq2XBq
3FxkZFJhVl5XXtlh7Gl5Xk5pT1znWe9w+utc6vD92uHRefToXdv/Y1FJXUhObV3s59PP1NBkWVFF
Tkpczlrg8XdtS2hzWtViXVdMTj5Y3v/Z8tT4785p2M/n51T8WUt7X/3t/d5k63VTemRWTUVcRUVb
R3Ly59PnxODhzurbXffpWd5eae7+5FlZ4FZZVlFeUGNXUeBldWH16Vzk9H3bbvZ0/n5RX25ldXfe
9HjvWmVoWGZd3vtY9Wvu7mryX+t2WGNm+lhd6GT6ef7fb95+adf2fW53/FlnZlz6WWRfa91Sa/Ru
6lvwfW3kW2lue3Ve4npsfmV+X1v1X3nyX/Po325b525taWD3eeT5a/J17GtZ419gbmd6XGz/auhr
c2Ro7lVp7W/0YmxqX+paaeXw93Dk4+3gdfXr+3ZecnZdcHxvaF9vY11qVmZ1bnJd3etx5nrn/X3u
Yen3bv3v7Wd36nX5dm96dXVdWPNhV2ZpeHrpcWHWe2p89/ZhdHNh62Rz/uzpZP3qd/V4+nNu+2N8
+2lvZ+5pWnlda3JedGftdG3o9Oh58+T/6Pt86fT1aWnxZGNtaHpybm1r7WRkbm5+Yn33euNv/u7y
8mn+6XTzenv1f3llaHlgZGxpemz0/3Trbn75//po7X1192p5bv93ZXxvb3V2+214+nf9fP97+u9x
c+/1///49vv1c3F/dXVuev91dXV4/3V1ff////ru7vD99fr/c251dXV1dX34eX9ueX51ffX1d///
df3z9fDu7v7/83h3dXRzbnVsaXV1dXV7/2/79v/v/fX19e91/fP19fX1fP97b25xbmlsdWxsdXp3
//n//PX2//f19fX19fX19ff//3x1dnt1dXV1dXV1dXX////99fX19fX19fX1/v///////////3l2
e3V1dXV1df///////////////////////////////////////////////31+////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

----Next_Part(Tue_Sep_18_09_41_48_2007_313)----
